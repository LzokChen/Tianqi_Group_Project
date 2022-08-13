//
//  WeatherModel.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/12/22.
//

import Foundation

class WeatherModel: Codable{
    let city : CityModel
    
    let current : CurrentWeatherModel
    let hourlyForecasts : [HourlyForecastModel]
    let dailyForecasts : [DailyForecastModel]
    
    let updateTime : Date
    
    init(city: CityModel, current : CurrentWeatherModel, hourlyForecasts : [HourlyForecastModel], dailyForecasts: [DailyForecastModel]) {
        self.city = city
        self.current = current
        self.hourlyForecasts = hourlyForecasts
        self.dailyForecasts = dailyForecasts
        self.updateTime = Date()
        
    }
}
