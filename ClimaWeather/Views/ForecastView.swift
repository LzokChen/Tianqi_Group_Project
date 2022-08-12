//
//  Temperature.swift
//  ClimaWeather
//
//  Created by 刘峥炫 on 2022/8/12.
//

import SwiftUI
import Lottie

struct CurrentWeather:Hashable {
    let city : String
    let time : String
    let temperature: String
    let description: String
    let pressure: String
    let humidity: String
    let windSpeed: String
}

struct DailyWeather:Hashable {
    let day : String
    let date : String
    let temperature: String
    let icon : String
}

struct HourlyWeather:Hashable {
    var hour : String
    let icon : String
    let temperature: String
}

struct ForecastView: View, WeatherManagerDelegate {
    @State private var currentWeather: CurrentWeather? = nil
    @State private var hasUpdatedCurrentWeather = false
    
    @State private var dailyWeathers = [DailyWeather]()
    @State private var hasUpdatedDailyWeather = false
    
    @State private var hourlyWeathers = [HourlyWeather]()
    @State private var hasUpdatedHourlyWeather = false
    
    /*
     let dailyWeahter : [DailyWeather] = [
     DailyWeather(day: "8月12日", date: "明日", temperature: "23º", icon: "sun.min"),
     DailyWeather(day: "8月13日", date: "星期一", temperature: "23º", icon: "sun.min.fill"),
     DailyWeather(day: "8月14日", date: "星期二", temperature: "23º", icon: "sun.max"),
     DailyWeather(day: "8月15日", date: "星期三", temperature: "23º", icon: "sun.max.fill"),
     DailyWeather(day: "8月16日", date: "星期四", temperature: "23º", icon: "cloud.drizzle"),
     DailyWeather(day: "8月17日", date: "星期五", temperature: "23º", icon: "cloud.drizzle.fill"),
     DailyWeather(day: "8月18日", date: "星期六", temperature: "23º", icon: "cloud.rain"),
     DailyWeather(day: "8月19日", date: "星期日", temperature: "23º", icon: "cloud.rain.fill"),
     DailyWeather(day: "8月20日", date: "星期一", temperature: "23º", icon: "cloud.snow"),
     DailyWeather(day: "8月21日", date: "星期二", temperature: "23º", icon: "cloud.snow.fill")
     ]*/
    
    //MARK: - WeatherManagerDelegate functions
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, weather: CurrentWeatherModel) {
        // Get the current date and time
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        currentWeather = CurrentWeather(city: weather.secondaryName,
                                        time: formatter.string(from: currentDateTime),
                                        temperature: weather.temperature,
                                        description: weather.condition,
                                        pressure: weather.pressure + "hpa",
                                        humidity: weather.humidity + "%",
                                        windSpeed: weather.windSpeed + "km/h")
        hasUpdatedCurrentWeather = true
        print(currentWeather ?? "")
    }
    
    func didUpdate24HoursForecast(_ weatherManager: WeatherManager, forecasts: [HourlyForecastModel]) {
        hourlyWeathers.removeAll()
        
        for (index, forecast) in forecasts.enumerated() {
            let hour: Int = (Int)(forecast.hour) ?? 0
            hourlyWeathers.append(
                HourlyWeather(hour: (index == 0) ? "现在" : String(format: "%02d时", hour),
                              icon: "W" + ((hour > 17 || hour < 6) ? forecast.iconNight : forecast.iconDay),
                              temperature: forecast.temperature
                             )
            )
        }
        hasUpdatedHourlyWeather = true
        print(forecasts[0].secondaryName, "24小时温度: ", hourlyWeathers)
    }
    
    /* Still have to update all the fields correspondingly. */
    func didUpdate15DaysForecast(_ weatherManager: WeatherManager, forecasts: [DailyForecastModel]) {
        dailyWeathers.removeAll()
        
        for forecast in forecasts {
            dailyWeathers.append(
                DailyWeather(day: "The day",
                             date: forecast.date,
                             temperature: forecast.tempDay + "º " + forecast.tempNight + "º",
                             icon: "W1")
            )
        }
        hasUpdatedDailyWeather = true
        print(forecasts[0].secondaryName, "15天天气: ", dailyWeathers)
    }
    
    var body: some View {
        //MARK: - Usage: create weatherManager and setup the delegate
        let wm = WeatherManager()
        let _ = wm.setDelegate(delegate: self)
        
        if (!hasUpdatedCurrentWeather) {
            //let _ = wm.fetchCurrentWeather(latitude: 22.555259, longitude: 113.88402)
            let _ = wm.fetchCurrentWeather(address: "上海")
        }
        
        if (!hasUpdatedDailyWeather) {
            let _ = wm.fetch15DaysForecast(address: "上海")
        }
        
        if (!hasUpdatedHourlyWeather) {
            let _ = wm.fetch24HoursForecast(address: "上海")
        }
        
        if (hasUpdatedCurrentWeather && hasUpdatedHourlyWeather && hasUpdatedDailyWeather) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    // Weather Card
                    VStack(alignment: .center){
                        // Location and time
                        HStack{
                            Image(systemName: "location.fill")
                            Text(currentWeather?.city ?? "Unknown City")
                                .fontWeight(.bold)
                            Spacer()
                            Text(currentWeather?.time ?? "Unknown Time")
                        }
                        
                        Spacer().frame(height: 35)
                        
                        // Temperature
                        HStack(alignment: .top, spacing: 0){
                            Text(currentWeather?.temperature ?? "Unknown Temperature")
                                .font(.system(size: 95, weight: .bold, design: .monospaced))
                            Text("º")
                                .font(.system(size: 30, weight: .bold, design: .monospaced))
                        }
                        
                        Spacer().frame(height: 2)
                        // Single description
                        Text(currentWeather?.description ?? "")
                        
                        Spacer().frame(height: 15)
                        
                        // Presure Huminity Wind
                        HStack{
                            HStack{
                                Image(systemName: "aqi.medium")
                                Text(currentWeather?.pressure ?? "N/A")
                            }
                            Spacer()
                            HStack{
                                Image(systemName: "humidity")
                                Text(currentWeather?.humidity ?? "N/A")
                            }
                            Spacer()
                            HStack{
                                Image(systemName: "wind")
                                Text(currentWeather?.windSpeed ?? "N/A")
                            }
                        }
                        
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.secondary.cornerRadius(10))
                    
                    Divider()
                    
                    // Today's Weather: Show hourly weather and temperature
                    // Horizontally Scrollable Component
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 12){
                            ForEach(hourlyWeathers, id: \.self){ weather in
                                VStack{
                                    Text(weather.hour)
                                        .font(.system(size: 14, weight: .bold))
                                    Spacer().frame(height: 5)
                                    Image(weather.icon)
                                        .renderingMode(.template)
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.secondary)
                                        .scaledToFill()
                                    Spacer().frame(height: 7)
                                    Text(weather.temperature + "º")
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    // Future daily weather
                    VStack{
                        ForEach(dailyWeathers, id:\.self){ weather in
                            HStack{
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(weather.date)
                                            .font(.system(size: 19, weight: .bold))
                                        Spacer().frame(height: 5)
                                        Text(weather.day)
                                            .font(.subheadline)
                                    }
                                    Spacer()
                                }
                                .frame(width: 100)
                                Spacer()
                                Text(weather.temperature)
                                Spacer()
                                Image(weather.icon)
                            }.padding()
                        }
                    }
                }
                .padding(.horizontal)
            }
        } else {
            VStack{
                LottieView(lottieFile: "load.json")
                    .frame(width: 300, height: 300)
                Text("Fetching the weather details...")
                    .frame(alignment: .center)
            }
        }
    }
}

struct Temperature_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
