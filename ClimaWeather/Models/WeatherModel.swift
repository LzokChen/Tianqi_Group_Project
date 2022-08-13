//
//  WeatherModel.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/12/22.
//

import Foundation

class WeatherModel{
    let name : String, //城市名称 （区）
        pname : String, //省份名称 （省）
        secondaryName : String //上级城市名称 （市）
    
    let current : CurrentWeatherModel
    let hourlyForecasts : [HourlyForecastModel]
    let dailyForecasts : [DailyForecastModel]
    
    let updateTime : Date
    
    init(name: String, pname: String, secondaryName: String, current : CurrentWeatherModel, hourlyForecasts : [HourlyForecastModel], dailyForecasts: [DailyForecastModel]) {
        self.name = name
        self.pname = pname
        self.secondaryName = secondaryName
        self.current = current
        self.hourlyForecasts = hourlyForecasts
        self.dailyForecasts = dailyForecasts
        self.updateTime = Date()
        
    }
}
