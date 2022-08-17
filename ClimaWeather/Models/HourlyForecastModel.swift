//
//  HourlyForecastsData.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/9/22.
//

import Foundation

//用于存储获取的单个小时天气预报
struct HourlyForecastModel: Codable{
    
    let condition : String, //气象
        conditionId : String,
        iconDay : String, //白天icon
        iconNight : String, //夜间icon
        date : String, //日期
        hour : String, //小时
        pop : String, //降水概率 百分比
        qpf : String, //未来一小时降水量 毫米
        realFeel : String, //体感温度
        temp : String //实际温度
}
