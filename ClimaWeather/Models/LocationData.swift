//
//  LocationData.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/9/22.
//

import Foundation

//the variable names must match with the json file
struct LocationData: Codable {   //Codable = Decodable, Encodable
    let geocodes : [Geocodes]
}

struct Geocodes: Codable{
    let location : String
}
