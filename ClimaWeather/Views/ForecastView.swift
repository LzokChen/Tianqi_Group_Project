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
    let day: String
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
    
    //MARK: - WeatherManagerDelegate functions
    /* Fetch current weather details - for the upper container */
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
                                        windSpeed: weather.windSpeed + "m/s")
        hasUpdatedCurrentWeather = true
        print(currentWeather ?? "")
    }
    
    /* Fetch hourly weather forecasts - for the middle container */
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
    
    /* Return the day of week of any date */
    func getDayNameBy(_ stringDate: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        let date = df.date(from: stringDate)!
        df.dateFormat = "EEEE"
        let dayInEng = df.string(from: date)
        
        func getDayInChn(_ var1: String) -> String {
            switch var1 {
            case "Monday":
                return "周一"
            case "Tuesday":
                return "周二"
            case "Wednesday":
                return "周三"
            case "Thursday":
                return "周四"
            case "Friday":
                return "周五"
            case "Saturday":
                return "周六"
            case "Sunday":
                return "周日"
            default:
                return "未知"
            }
        }
        
        return getDayInChn(dayInEng)
    }
    
    /* Fetch daily weather forecasts - for the bottom container */
    func didUpdate15DaysForecast(_ weatherManager: WeatherManager, forecasts: [DailyForecastModel]) {
        dailyWeathers.removeAll()
        
        for (index, forecast) in forecasts.enumerated() {
            dailyWeathers.append(
                DailyWeather(day: getDayNameBy(forecast.date) + (index == 0 ? " (今天)" : index == 1 ? " (明天)" : index == 2 ? " (后天)" : ""),
                             date: String((forecast.date).suffix(5)),
                             temperature: forecast.tempDay + "º ~ " + forecast.tempNight + "º",
                             icon: "W" + forecast.conditionIdDay)
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
        
        if (!hasUpdatedCurrentWeather || !hasUpdatedHourlyWeather || !hasUpdatedDailyWeather) {
            VStack{
                LottieView(lottieFile: "load.json")
                    .frame(width: 300, height: 300)
                Text("Fetching the weather details...")
                    .frame(alignment: .center)
            }
        } else {
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
                                        .frame(width: 60, height: 60)
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
        }
    }
}

struct Temperature_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
