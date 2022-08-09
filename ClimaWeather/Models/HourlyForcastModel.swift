//
//  HourlyForcastsData.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/9/22.
//

import Foundation

class HourlyForcastModel{
    let name : String, //城市名称 （区）
        pname : String, //省份名称 （省）
        secondaryName : String //上级城市名称 （市）
    
    let condition : String,
        conditionId : Int,
        iconDay : String, //白天icon
        iconNight : String, //夜间icon
        date : String,
        hour : String,
        pop : String, //降水概率 百分比
        realFeel : String, //体感温度
        temperature : String //实际温度
    
    init(name: String, pname: String, secondaryName: String, condiction: String, conditionId: String, iconDay: String, iconNight: String, date: String, hour : String, pop : String, realFeel : String, temp : String) {
        
        self.name = name
        self.pname = pname
        self.secondaryName = secondaryName
        self.condition = condiction
        self.conditionId = Int(conditionId)!
        self.iconDay = iconDay
        self.iconNight = iconNight
        self.date = date
        self.hour = hour
        self.pop = pop
        self.realFeel = realFeel
        self.temperature = temp
    }
    
        
}
