//
//  DailyForecastModel.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/9/22.
//

import Foundation

//用于存储获取的单日的天气预报
struct DailyForecastModel: Codable{
    
    let conditionDay : String, //白天气象
        conditionNight : String, //夜间气象
        conditionIdDay : String, //白天icon
        conditionIdNight : String, //夜间icon
        predictDate : String, //日期
        pop : String, //降水概率 百分比
        tempDay : String, //白天温度，最高温度
        tempNight : String //夜晚温度，最低温度
        
}
