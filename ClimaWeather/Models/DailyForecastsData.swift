//
//  DailyForecastData.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/9/22.
//

import Foundation

//for json parsing
struct DailyForecastsData: Codable {
    let data : dData
}

struct dData: Codable{
    let city : City
    let forecast : [DailyForecast]
}

struct DailyForecast : Codable{
    let conditionDay : String,
        conditionNight : String,
        conditionIdDay : String, //白天icon
        conditionIdNight : String, //夜间icon
        predictDate : String,
        pop : String, //降水概率 百分比
        tempDay : String, //白天温度，最高温度
        tempNight : String, //夜晚温度，最低温度
        windDirDay : String, //白天风向
        windDirNight : String, //夜晚风向
        windLevelDay : String,  //白天风力等级
        windLevelNight : String //夜晚风力等级
        
        
}
