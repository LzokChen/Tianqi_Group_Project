//
//  DailyForecastModel.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/9/22.
//

import Foundation

class DailyForecastModel{
    let name : String, //城市名称 （区）
        pname : String, //省份名称 （省）
        secondaryName : String //上级城市名称 （市）
    
    let conditionDay : String,
        conditionNight : String,
        conditionIdDay : String, //白天icon
        conditionIdNight : String, //夜间icon
        date : String,
        pop : String, //降水概率 百分比
        tempDay : String, //白天温度，最高温度
        tempNight : String //夜晚温度，最低温度
    
    init(name: String, pname: String, secondaryName: String, conditionDay: String, conditionNight: String, conditionIdDay: String, conditionIdNight: String, date: String, pop : String, tempDay : String, tempNight : String) {
        
        self.name = name
        self.pname = pname
        self.secondaryName = secondaryName
        self.conditionDay = conditionDay
        self.conditionNight = conditionNight
        self.conditionIdDay = conditionIdDay
        self.conditionIdNight = conditionIdNight
        self.date = date
        self.pop = pop
        self.tempDay = tempDay
        self.tempNight = tempNight
    }
    
        
}
