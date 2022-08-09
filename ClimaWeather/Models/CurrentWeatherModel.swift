//
//  CurrentWeatherModel.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/8/22.
//

import Foundation


class CurrentWeatherModel {
    let name : String, //城市名称 （区）
        pname : String, //省份名称 （省）
        secondaryName : String //上级城市名称 （市）
    
    let condition : String, //实时气象
        conditionId : Int,
        humidity : String, //湿度 百分比
        weatherIcon : String, //天气图标，对应Assets.xcassets/天气图标
        pressure : String, //气压 百帕
        realFeel : String, //体感温度 摄氏度
        temperature : String, //温度 摄氏度
        uvi : String, //紫外线强度
        vis : String, //能见度 米
        windDegrees : String, //风向角度 度
        windDir : String, //风向
        windLevel : String, //风级
        windSpeed : String, //风速
        tips : String //一句话提示
    
    let sunRise : String, //日出时间
        sunSet : String //日落时间
    
    init(name: String, pname: String, secondaryName: String, condition: String, conditionId: String, humidity: String,
         weatherIcon: String, pressure: String, realFeel: String, temperature: String, uvi: String, vis: String,
         windDegrees: String, windDir: String, windLevel: String, windSpeed: String, tips: String, sunRise: String, sunSet: String) {
        self.name = name
        self.pname = pname
        self.secondaryName = secondaryName
        self.condition = condition
        self.conditionId = Int(conditionId)!
        self.humidity = humidity
        self.weatherIcon = weatherIcon
        self.pressure = pressure
        self.realFeel = realFeel
        self.temperature = temperature
        self.uvi = uvi
        self.vis = vis
        self.windDegrees = windDegrees
        self.windDir = windDir
        self.windLevel = windLevel
        self.windSpeed = windSpeed
        self.tips = tips
    
        self.sunRise = sunRise
        self.sunSet = sunSet
    }
}
