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
    
    let condition : String,
        conditionId : Int,
        humidity : String,
        weatherIcon : String,
        pressure : String,
        realFeel : String,
        temperature : String,
        uvi : String,
        vis : String,
        windDegrees : String,
        windDir : String,
        windLevel : String,
        windSpeed : String,
        tips : String
    
    let sunRise : String,
        sunSet : String
    
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
