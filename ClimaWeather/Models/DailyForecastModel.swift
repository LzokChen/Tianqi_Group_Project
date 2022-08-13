//
//  DailyForecastModel.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/9/22.
//

import Foundation

class DailyForecastModel{
    
    let conditionDay : String, //白天气象
        conditionNight : String, //夜间气象
        conditionIdDay : String, //白天icon
        conditionIdNight : String, //夜间icon
        date : String, //日期
        pop : String, //降水概率 百分比
        tempDay : String, //白天温度，最高温度
        tempNight : String, //夜晚温度，最低温度
        windDirDay : String, //白天风向
        windDirNight : String, //夜晚风向
        windLevelDay : String,  //白天风力等级
        windLevelNight : String //夜晚风力等级
    
    init(conditionDay: String, conditionNight: String, conditionIdDay: String, conditionIdNight: String, date: String, pop : String, tempDay : String, tempNight : String, windDirDay: String, windDirNight: String, windLevelDay: String, windLevelNight: String) {
        
        self.conditionDay = conditionDay
        self.conditionNight = conditionNight
        self.conditionIdDay = conditionIdDay
        self.conditionIdNight = conditionIdNight
        self.date = date
        self.pop = pop
        self.tempDay = tempDay
        self.tempNight = tempNight
        self.windDirDay = windDirDay
        self.windDirNight = windDirNight
        self.windLevelDay = windLevelDay
        self.windLevelNight = windLevelNight
    }
    
        
}
