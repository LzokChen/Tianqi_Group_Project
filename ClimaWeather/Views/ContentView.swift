//
//  ContentView.swift
//  ClimaWeather
//
//  Created by Xiaojian Chen on 8/8/22.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
        TabView{
            WeatherDetailView()
                .tabItem{
                    Image(systemName: "wind")
                    Text("实时天气")
                }
            ForecastView()
                .tabItem{
                    Image(systemName: "cloud.fill")
                    Text("天气预报")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

