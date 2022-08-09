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
    
    func didUpdate24HourForecasts(_ weatherManager: WeatherManager, forecasts: [HourlyForecastModel])
    //func didFailWithError(error : Error)
}

extension WeatherManagerDelegate{
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, weather: CurrentWeatherModel){print("no didUpdateCurrentWeather")}
    func didUpdate24HourForecasts(_ weatherManager: WeatherManager, forecasts: [HourlyForecastModel]){print("no didUpdate24HourForecasts")}
}


class WeatherManager {
    let curWeatherURL = "http://aliv8.data.moji.com/whapi/json/aliweather/condition"
    let hourlyForecastURL = "http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours"
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
    
    func fetch24HoursForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        self.request24HoursForecast(latitude: latitude, longitude: longitude)
    }
    
    func fetch24HoursForecast(address: String){
        let params = ["key":"57115a6e1f71cc02273d01b7d60b1e24", "address": address]
        AF.request(getLocationURL, method: .get, parameters: params, encoding: URLEncoding.queryString).validate(statusCode: 200..<299).responseData { response in
            switch response.result {
                case .success(let data):
                    if let location = self.parseLocationData(data){
                        self.request24HoursForecast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
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
    
    private func request24HoursForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let params = [
                "lat": String(latitude),
                "lon": String(longitude),
                "token": "1b89050d9f64191d494c806f78e8ea36"
            ]
            
        AF.request(hourlyForecastURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: HTTPHeaders(mojiHeaders)).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    if let hourlyForecasts = self.parseHourlyForecastsData(data){
                        self.delegate?.didUpdate24HourForecasts(self, forecasts: hourlyForecasts)
   
                    }else{
                        print("Error: Fail to convert JSON data to hourlyForecastModels")
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
    
    private func parseHourlyForecastsData(_ forecastData: Data) -> [HourlyForecastModel]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(HourlyForecastsData.self, from: forecastData)
            let city = decodedData.data.city
            let forecasts = decodedData.data.hourly
            
            var forecastModels : [HourlyForecastModel] = []
            
            for forecast in forecasts {
                let model = HourlyForecastModel(name: city.name, pname: city.pname, secondaryName: city.secondaryname, condiction: forecast.condition, conditionId: forecast.conditionId, iconDay: forecast.iconDay, iconNight: forecast.iconNight, date: forecast.date, hour: forecast.hour, pop: forecast.pop, realFeel: forecast.realFeel, temp: forecast.temp)
                forecastModels.append(model)
            }
            
            return forecastModels
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
   

}
