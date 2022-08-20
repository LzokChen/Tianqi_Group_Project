//
//  CurrentWeatherModel.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/8/22.
//

import Foundation

//用于存储获取的实时天气数据
struct CurrentWeatherModel: Codable {
    
    let condition : String, //实时气象
        conditionId : String,
        humidity : String, //湿度 百分比
        icon : String, //天气图标，对应Assets.xcassets/天气图标
        pressure : String, //气压 百帕
        realFeel : String, //体感温度 摄氏度
        temp : String, //温度 摄氏度
        uvi : String, //紫外线强度
        vis : String, //能见度 米
        windDir : String, //风向
        windSpeed : String, //风速
        tips : String //一句话提示
    
    let sunRise : String, //日出时间
        sunSet : String //日落时间
}
