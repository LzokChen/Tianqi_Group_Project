//
//  ContentView.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/8/22.
//

import SwiftUI
import CoreLocation

struct ContentView: View, WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        let curWeatherModel = weather as! CurrentWeatherModel
        print(curWeatherModel.name, curWeatherModel.temperature)
        print(curWeatherModel.tips)
    }
    
    
    var body: some View {
        let wm = WeatherManager()
        let _ = print(wm.delegate = self)
        let _ = wm.fetchCurrentWeather(latitude: 22.555259, longitude: 113.88402)
        let _ = wm.fetchCurrentWeather(address: "上海虹桥机场")
        
        
        
        Text("Hello, world!")
            .padding()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
        
    }
}

