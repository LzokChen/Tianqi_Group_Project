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
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)  //first param -> the object who will use this function
    //func didFailWithError(error : Error)
}

class WeatherManager {
    let curWeatherURL = "http://aliv8.data.moji.com/whapi/json/aliweather/condition"
    let headers = ["Authorization": "APPCODE 1bb40f32e8384e04bef97ae3d628274e", "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"]
    
    var delegate: WeatherManagerDelegate?
    
    
    
    func requestCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let params = [
                "lat": String(latitude),
                "lon": String(longitude),
                "token": "ff826c205f8f4a59701e64e9e64e01c4"
            ]
            
        AF.request(curWeatherURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: HTTPHeaders(headers)).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
//                    let dataString = String(data: data, encoding: .utf8)
//                    print(dataString)
                    if let weatherModel = self.parseCurWeatherData(data){
                        self.delegate?.didUpdateWeather(self, weather: weatherModel)
                    }else{
                        print("Error: Trying to convert JSON data to currentWeatherModel")
                        
                    }
                
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func parseCurWeatherData(_ weatherData: Data) -> CurrentWeatherModel?{
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

}
