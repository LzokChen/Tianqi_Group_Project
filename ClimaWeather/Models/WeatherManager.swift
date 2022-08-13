//
//  WeatherManager.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/8/22.
//

import Foundation
import CoreLocation
import Alamofire

//MARK: - WeatherManagerDeleage
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    //func didFailWithError(error : Error)
}

//MARK: - WeatherManager
class WeatherManager {
    let curWeatherURL = "http://aliv8.data.moji.com/whapi/json/aliweather/condition"
    let hourlyForecastURL = "http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours"
    let dailyForecastURL = "http://aliv8.data.moji.com/whapi/json/aliweather/forecast15days"
    let getLocationURL = "http://restapi.amap.com/v3/geocode/geo?parameters"
    
    let mojiHeaders = ["Authorization": "APPCODE 1bb40f32e8384e04bef97ae3d628274e", "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"]
    
    private var delegates : [WeatherManagerDelegate] = []
    private var weather : WeatherModel?
    
    
    //singleton mode
    static let shared = WeatherManager()
    private init(){}
    
    func addDelegate(with delegate: WeatherManagerDelegate){
        self.delegates.append(delegate)
    }
    

    //MARK: - Fetch functions
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, withLatest: Bool){
        if (withLatest || self.weather == nil){
            self.requestWeather(latitude: latitude, longitude: longitude)
        }else{
            for delegate in self.delegates {
                delegate.didUpdateWeather(self, weather: self.weather!)
            }
        }
        
        
    }
    
    func fetchWeather(address: String, withLatest: Bool){
        if (withLatest || self.weather == nil){
            let params = ["key":"57115a6e1f71cc02273d01b7d60b1e24", "address": address]
            AF.request(getLocationURL, method: .get, parameters: params, encoding: URLEncoding.queryString).validate(statusCode: 200..<299).responseData { response in
                switch response.result {
                case .success(let data):
                    if let location = self.parseLocationData(data){
                        self.requestWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    }else{
                        print("Error: Fail to parse location JSON")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            for delegate in self.delegates {
                delegate.didUpdateWeather(self, weather: self.weather!)
            }
        }
        
    }

    
    //MARK: - HTTP requests with Alamofire
    private func requestWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        var current : CurrentWeatherModel?
        var hourlyForecasts : [HourlyForecastModel]?
        var dailyForecasts: [DailyForecastModel]?
        
        let requestGroup = DispatchGroup()
        
        requestGroup.enter()
        requestGroup.enter()
        requestGroup.enter()
        
        self.requestCurrentWeather(latitude: latitude, longitude: longitude) { model in
            current = model
            requestGroup.leave()
        }
        
        self.request24HoursForecast(latitude: latitude, longitude: longitude) { models in
            hourlyForecasts = models
            requestGroup.leave()
        }
        
        self.request15DaysForecast(latitude: latitude, longitude: longitude) { models in
            dailyForecasts = models
            requestGroup.leave()
        }
        
        DispatchQueue.global(qos: .background).async {
            requestGroup.wait()
            DispatchQueue.main.async {
                if let safeCurrent = current, let safeHourlyForecasts = hourlyForecasts, let safeDailyForecasts = dailyForecasts{
                    self.weather = WeatherModel(name: safeCurrent.name, pname: safeCurrent.pname, secondaryName: safeCurrent.secondaryName,
                                                current: safeCurrent, hourlyForecasts: safeHourlyForecasts, dailyForecasts: safeDailyForecasts)
                    print("Successfully requesting the latest weather")
                    for delegate in self.delegates {
                        delegate.didUpdateWeather(self, weather: self.weather!)
                    }
                }else{
                    print("Error, fail to fetch Weather")
                }
                
            }
        }
        
    }
    
    private func requestCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completeion: @escaping (_ model: CurrentWeatherModel?) -> Void){
        let params = [
            "lat": String(latitude),
            "lon": String(longitude),
            "token": "ff826c205f8f4a59701e64e9e64e01c4"
        ]
        
        AF.request(curWeatherURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: HTTPHeaders(mojiHeaders)).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                if let currentWeatherModel = self.parseCurWeatherData(data){
                    completeion(currentWeatherModel)
                    // self.delegate?.didUpdateCurrentWeather(self, weather: weatherModel)
                }else{
                    print("Error: Fail to convert JSON data to currentWeatherModel")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func request24HoursForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completeion: @escaping (_ models: [HourlyForecastModel]?) -> Void){
        let params = [
            "lat": String(latitude),
            "lon": String(longitude),
            "token": "1b89050d9f64191d494c806f78e8ea36"
        ]
        
        AF.request(hourlyForecastURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: HTTPHeaders(mojiHeaders)).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                if let hourlyForecasts = self.parseHourlyForecastsData(data){
                    completeion(hourlyForecasts)
                    
                }else{
                    print("Error: Fail to convert JSON data to hourlyForecastModels")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func request15DaysForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completeion: @escaping (_ models: [DailyForecastModel]?) -> Void){
        let params = [
            "lat": String(latitude),
            "lon": String(longitude),
            "token": "7538f7246218bdbf795b329ab09cc524"
        ]
        
        AF.request(dailyForecastURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: HTTPHeaders(mojiHeaders)).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                if let dailyForecasts = self.parseDailyForecastsData(data){
                    completeion(dailyForecasts)
                }else{
                    print("Error: Fail to convert JSON data to dailyForecastModels")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - JSON parsers
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
            let forecasts = decodedData.data.hourly
            
            var forecastModels : [HourlyForecastModel] = []
            
            for forecast in forecasts {
                let model = HourlyForecastModel(condiction: forecast.condition, conditionId: forecast.conditionId,
                                                iconDay: forecast.iconDay, iconNight: forecast.iconNight,
                                                date: forecast.date, hour: forecast.hour,
                                                pop: forecast.pop, qpf: forecast.qpf, realFeel: forecast.realFeel, temp: forecast.temp)
                forecastModels.append(model)
            }
            return forecastModels
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func parseDailyForecastsData(_ forecastData: Data) -> [DailyForecastModel]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DailyForecastsData.self, from: forecastData)
            let forecasts = decodedData.data.forecast
            
            var forecastModels : [DailyForecastModel] = []
            
            for forecast in forecasts {
                let model = DailyForecastModel(conditionDay: forecast.conditionDay, conditionNight: forecast.conditionNight,
                                               conditionIdDay: forecast.conditionIdDay, conditionIdNight: forecast.conditionIdNight,
                                               date: forecast.predictDate,
                                               pop: forecast.pop, tempDay: forecast.tempDay, tempNight: forecast.tempNight,
                                               windDirDay: forecast.windDirDay, windDirNight: forecast.windDirNight, windLevelDay: forecast.windLevelDay, windLevelNight: forecast.windLevelNight)
                forecastModels.append(model)
            }
            return forecastModels
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    
}
