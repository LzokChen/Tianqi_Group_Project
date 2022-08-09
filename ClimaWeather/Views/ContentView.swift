//
//  ContentView.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/8/22.
//

import SwiftUI

struct ContentView: View, WeatherManagerDelegate {
    
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        let curWeatherModel = weather as! CurrentWeatherModel
        print(curWeatherModel.name, curWeatherModel.temperature)
        print(curWeatherModel.tips)
    }
    
    
    var body: some View {
        let wm = WeatherManager()
        let _ = print(wm.delegate = self)
        let _ = wm.requestCurrentWeather(latitude: 39.91488908, longitude: 116.40387397)
        
        
        
        Text("Hello, world!")
            .padding()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
        
    }
}

