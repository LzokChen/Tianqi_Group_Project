//
//  WeatherModel.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/12/22.
//

import Foundation

//用于存储获取的天气数据
struct WeatherModel: Codable{
    let city : CityModel
    
    let current : CurrentWeatherModel
    let hourlyForecasts : [HourlyForecastModel]
    let dailyForecasts : [DailyForecastModel]
    
    let updateTime : Date
    
}
