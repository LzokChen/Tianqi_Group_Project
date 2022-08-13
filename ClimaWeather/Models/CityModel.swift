//
//  LocationModel.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/12/22.
//

import Foundation

class CityModel: Codable {
    let name : String, //城市名称 （区）
        pname : String, //省份名称 （省）
        secondaryName : String //上级城市名称 （市）
    
    init(name : String, pname : String, secondaryName :String) {
        self.name = name
        self.pname = pname
        self.secondaryName = secondaryName
    }
}
