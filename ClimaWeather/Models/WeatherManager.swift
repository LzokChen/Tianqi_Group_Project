//
//  WeatherManager.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/8/22.
//

import Foundation
import CoreLocation
import Alamofire


protocol WeatherManagerDelegate {
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, weather: CurrentWeatherModel)
    
    func didUpdate24HourForcasts(_ weatherManager: WeatherManager, forcasts: [HourlyForcastModel])
    //func didFailWithError(error : Error)
}

extension WeatherManagerDelegate{
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, weather: CurrentWeatherModel){print("no didUpdateCurrentWeather")}
    func didUpdate24HourForcasts(_ weatherManager: WeatherManager, forcasts: [HourlyForcastModel]){print("no didUpdate24HourForcasts")}
}


class WeatherManager {
    let curWeatherURL = "http://aliv8.data.moji.com/whapi/json/aliweather/condition"
    let hourlyForcastURL = "http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours"
    let mojiHeaders = ["Authorization": "APPCODE 1bb40f32e8384e04bef97ae3d628274e", "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"]
    
    let getLocationURL = "http://restapi.amap.com/v3/geocode/geo?parameters"
    
    var delegate : WeatherManagerDelegate?
    
    
    func fetchCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        self.requestCurrentWeather(latitude: latitude, longitude: longitude)
    }
    
    func fetchCurrentWeather(address: String){
        let params = ["key":"57115a6e1f71cc02273d01b7d60b1e24", "address": address]
        AF.request(getLocationURL, method: .get, parameters: params, encoding: URLEncoding.queryString).validate(statusCode: 200..<299).responseData { response in
            switch response.result {
                case .success(let data):
                    if let location = self.parseLocationData(data){
                        self.requestCurrentWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    }else{
                        print("Error: Fail to parse location JSON")
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func fetch24HoursForcast(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        self.request24HoursForcast(latitude: latitude, longitude: longitude)
    }
    
    func fetch24HoursForcast(address: String){
        let params = ["key":"57115a6e1f71cc02273d01b7d60b1e24", "address": address]
        AF.request(getLocationURL, method: .get, parameters: params, encoding: URLEncoding.queryString).validate(statusCode: 200..<299).responseData { response in
            switch response.result {
                case .success(let data):
                    if let location = self.parseLocationData(data){
                        self.request24HoursForcast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    }else{
                        print("Error: Fail to parse location JSON")
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    private func requestCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let params = [
                "lat": String(latitude),
                "lon": String(longitude),
                "token": "ff826c205f8f4a59701e64e9e64e01c4"
            ]
            
        AF.request(curWeatherURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: HTTPHeaders(mojiHeaders)).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    if let weatherModel = self.parseCurWeatherData(data){
                        self.delegate?.didUpdateCurrentWeather(self, weather: weatherModel)
   
                    }else{
                        print("Error: Fail to convert JSON data to currentWeatherModel")
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func request24HoursForcast(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let params = [
                "lat": String(latitude),
                "lon": String(longitude),
                "token": "1b89050d9f64191d494c806f78e8ea36"
            ]
            
        AF.request(hourlyForcastURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: HTTPHeaders(mojiHeaders)).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    if let hourlyForcasts = self.parseHourlyForcastsData(data){
                        self.delegate?.didUpdate24HourForcasts(self, forcasts: hourlyForcasts)
   
                    }else{
                        print("Error: Fail to convert JSON data to hourlyForcastModels")
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func parseLocationData(_ locationData: Data) -> CLLocation?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(LocationData.self, from: locationData)
            let coordinates = decodedData.geocodes[0].location.components(separatedBy: ",")
            
            return CLLocation(latitude: Double(coordinates[1])!, longitude: Double(coordinates[0])!)
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func parseCurWeatherData(_ weatherData: Data) -> CurrentWeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrentWeatherData.self, from: weatherData) //use .self to make it a value type
            let city = decodedData.data.city
            let condition = decodedData.data.condition
            
            let CurrentWeather = CurrentWeatherModel(name: city.name, pname: city.pname, secondaryName: city.secondaryname,
                                                     condition: condition.condition, conditionId: condition.conditionId, humidity: condition.humidity, weatherIcon: condition.icon,
                                                     pressure: condition.pressure, realFeel: condition.realFeel, temperature: condition.temp, uvi: condition.uvi, vis: condition.vis,
                                                     windDegrees: condition.windDegrees, windDir: condition.windDir, windLevel: condition.windLevel, windSpeed: condition.windSpeed,
                                                     tips: condition.tips, sunRise: condition.sunRise, sunSet: condition.sunSet)
            return CurrentWeather
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func parseHourlyForcastsData(_ forcastData: Data) -> [HourlyForcastModel]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(HourlyForcastsData.self, from: forcastData)
            let city = decodedData.data.city
            let forcasts = decodedData.data.hourly
            
            var forcastModels : [HourlyForcastModel] = []
            
            for forcast in forcasts {
                let model = HourlyForcastModel(name: city.name, pname: city.pname, secondaryName: city.secondaryname, condiction: forcast.condition, conditionId: forcast.conditionId, iconDay: forcast.iconDay, iconNight: forcast.iconNight, date: forcast.date, hour: forcast.hour, pop: forcast.pop, realFeel: forcast.realFeel, temp: forcast.temp)
                forcastModels.append(model)
            }
            
            return forcastModels
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
   

}
