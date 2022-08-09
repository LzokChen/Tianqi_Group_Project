//
//  ContentView.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/8/22.
//

import SwiftUI
import CoreLocation

struct ContentView: View, WeatherManagerDelegate {
    
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, weather: CurrentWeatherModel) {
        
        print(weather.pname, weather.secondaryName, weather.name, weather.temperature)
        print(weather.tips)
    }
    
    func didUpdate24HourForecasts(_ weatherManager: WeatherManager, forecasts: [HourlyForecastModel]) {
        var temps : [String] = []
        for forecast in forecasts {
            temps.append(forecast.temperature)
        }
        
        print(forecasts[0].secondaryName, temps)
    }
    
    
    var body: some View {
        let wm = WeatherManager()
        let _ = print(wm.delegate = self)
        let _ = wm.fetchCurrentWeather(latitude: 22.555259, longitude: 113.88402)
        let _ = wm.fetchCurrentWeather(address: "上海")
        let _ = wm.fetch24HoursForecast(address: "上海")
        
        
        
        
        
        
        Text("Hello, world!")
            .padding()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
        
    }
}

