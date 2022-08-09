//
//  HourlyForecastsData.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/9/22.
//

import Foundation

//for json parsing
struct HourlyForecastsData : Codable{
    let data : hData
}

struct hData: Codable{
    let city : City
    let hourly : [HourlyForecast]
}

struct HourlyForecast : Codable{
    let condition : String,
        conditionId : String,
        iconDay : String, //白天icon
        iconNight : String, //夜间icon
        date : String,
        hour : String,
        pop : String, //降水概率 百分比
        realFeel : String, //体感温度
        temp : String //实际温度
}
