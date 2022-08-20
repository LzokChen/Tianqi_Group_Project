//
//  CurrentWeatherData.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/8/22.
//

import Foundation

//for parsing the json file
struct CurrentWeatherData: Codable {   //Codable = Decodable, Encodable
    let data : wData
}

struct wData: Codable{
    let city : City
    let condition : Condition
}

struct City: Codable {
    let name : String, //城市名称 （区）
        pname : String, //省份名称 （省）
        secondaryname : String //上级城市名称 （市）
}

struct Condition: Codable {
    let condition : String,
        conditionId : String,
        humidity : String,
        icon : String,
        pressure : String,
        realFeel : String,
        temp : String,
        uvi : String,
        vis : String,
        windDir : String,
        windSpeed : String,
        tips : String,
        sunRise : String,
        sunSet : String
}
