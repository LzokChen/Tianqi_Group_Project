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

