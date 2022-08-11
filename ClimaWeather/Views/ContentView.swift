//
//  ContentView.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/8/22.
//

import SwiftUI
import CoreLocation

struct ContentView: View, WeatherManagerDelegate {
    
    //MARK: - WeatherManagerDelegate functions
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, weather: CurrentWeatherModel) {
        print(weather.pname, weather.secondaryName, weather.name, weather.temperature, weather.sunRise, weather.sunSet)
        print(weather.tips)
    }
    
    func didUpdate24HoursForecast(_ weatherManager: WeatherManager, forecasts: [HourlyForecastModel]) {
        var temps : [String] = []
        for forecast in forecasts {
            temps.append(forecast.temperature)
        }
        print(forecasts[0].secondaryName, "24小时温度: ", temps)
    }
    
    func didUpdate15DaysForecast(_ weatherManager: WeatherManager, forecasts: [DailyForecastModel]) {
        var conditions : [String] = []
        for forecast in forecasts {
            conditions.append(forecast.conditionDay)
        }
        print(forecasts[0].secondaryName, "15天天气: ", conditions)
    }
    
    
    var body: some View {
        //MARK: - Usage: create weatherManager and setup the delegate
        let wm = WeatherManager()
        let _ = print(wm.delegate = self)
        let _ = wm.fetchCurrentWeather(latitude: 22.555259, longitude: 113.88402)
        let _ = wm.fetchCurrentWeather(address: "上海")
        let _ = wm.fetch24HoursForecast(address: "上海")
        let _ = wm.fetch15DaysForecast(address: "上海")
        
        
        
        
        TabView{
            Temperature()
                .tabItem{
                    Image(systemName: "cloud.fill")
                    Text("天气预报")
                }
            WeatherDetail()
                .tabItem{
                    Image(systemName: "wind")
                    Text("空气质量")
                }
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
        
    }
}

