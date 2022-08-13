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
    let updateTime : String
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

/* The View for "天气预报" screen. */
struct ForecastView: View, WeatherManagerDelegate {
    @State private var hasUpdatedWeather = false
    
    @State private var currentWeather: CurrentWeather? = nil
    @State private var dailyWeathers = [DailyWeather]()
    @State private var hourlyWeathers = [HourlyWeather]()

    
    //MARK: - WeatherManagerDelegate functions
    /* Fetch current weather details - for the upper container */
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // Get the current date and time
        let updateDateTime = weather.updateTime
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        currentWeather = CurrentWeather(city: weather.secondaryName,
                                        updateTime: formatter.string(from: updateDateTime),
                                        temperature: weather.current.temp,
                                        description: weather.current.condition,
                                        pressure: weather.current.pressure + "hpa",
                                        humidity: weather.current.humidity + "%",
                                        windSpeed: weather.current.windSpeed + "m/s")
       
        
        hourlyWeathers.removeAll()
        for (index, forecast) in weather.hourlyForecasts.enumerated() {
            let hour: Int = (Int)(forecast.hour) ?? 0
            hourlyWeathers.append(
                HourlyWeather(hour: (index == 0) ? "现在" : String(format: "%02d时", hour),
                              icon: "W" + ((hour > 17 || hour < 6) ? forecast.iconNight : forecast.iconDay),
                              temperature: forecast.temp
                             )
            )
        }
        
        
        dailyWeathers.removeAll()
        for (index, forecast) in weather.dailyForecasts.enumerated() {
            dailyWeathers.append(
                DailyWeather(day: getDayNameBy(forecast.predictDate) + (index == 0 ? " (今天)" : index == 1 ? " (明天)" : index == 2 ? " (后天)" : ""),
                             date: String((forecast.predictDate).suffix(5)),
                             temperature: forecast.tempDay + "º ~ " + forecast.tempNight + "º",
                             icon: "W" + forecast.conditionIdDay)
            )
        }
        self.hasUpdatedWeather = true
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
    
    var body: some View {
        //MARK: - Usage: create weatherManager and setup the delegate
        let wm = WeatherManager.shared
        let _ = wm.addDelegate(with: self)
        
        if (!hasUpdatedWeather) {
            //let _ = wm.fetchCurrentWeather(latitude: 22.555259, longitude: 113.88402)
            let _ = wm.fetchWeather(address: "上海", withLatest: false)
        }
        
        // When data hasn't been fetched, show the loading animation.
        if (!hasUpdatedWeather) {
            VStack{
                LottieView(lottieFile: "load.json")
                    .frame(width: 300, height: 180)
                Text("Fetching the weather details...")
                    .frame(alignment: .center)
            }
        } else {
            RefreshableScrollView{
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
                                Text("更新时间:"+(currentWeather?.updateTime ?? "Unknown Time"))
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
            } onRefresh: {
                // Fetch all data again when user pulls to refresh the screen.
                let _ = wm.fetchWeather(address: "上海", withLatest: true)
               
            }
        }
    }
}

struct Temperature_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
