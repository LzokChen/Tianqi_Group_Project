//
//  Temperature.swift
//  ClimaWeather
//
//  Created by 刘峥炫 on 2022/8/12.
//

import SwiftUI


struct DailyWeather:Hashable {
    let day : String
    let date : String
    let temperture: String
    let icon : String
}

struct Temperature: View {
    let weathers: [String] = ["现在","00 时","01 时","02 时","03 时","04 时","05 时","06 时","07 时"]
    
    let dailyWeahter : [DailyWeather] = [
        DailyWeather(day: "8月12日", date: "明日", temperture: "23º", icon: "sun.min"),
        DailyWeather(day: "8月13日", date: "星期一", temperture: "23º", icon: "sun.min.fill"),
        DailyWeather(day: "8月14日", date: "星期二", temperture: "23º", icon: "sun.max"),
        DailyWeather(day: "8月15日", date: "星期三", temperture: "23º", icon: "sun.max.fill"),
        DailyWeather(day: "8月16日", date: "星期四", temperture: "23º", icon: "cloud.drizzle"),
        DailyWeather(day: "8月17日", date: "星期五", temperture: "23º", icon: "cloud.drizzle.fill"),
        DailyWeather(day: "8月18日", date: "星期六", temperture: "23º", icon: "cloud.rain"),
        DailyWeather(day: "8月19日", date: "星期日", temperture: "23º", icon: "cloud.rain.fill"),
        DailyWeather(day: "8月20日", date: "星期一", temperture: "23º", icon: "cloud.snow"),
        DailyWeather(day: "8月21日", date: "星期二", temperture: "23º", icon: "cloud.snow.fill")
    ]
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                // Weather Card
                VStack(alignment: .center){
                    // Location and time
                    HStack{
                        Image(systemName: "location.fill")
                        Text("深圳市")
                            .fontWeight(.bold)
                        Spacer()
                        Text("08:52 上午")
                    }
                    
                    Spacer().frame(height: 35)
                    
                    // Temperature
                    HStack(alignment: .top, spacing: 0){
                        Text("22")
                            .font(.system(size: 95, weight: .bold, design: .monospaced))
                        Text("º")
                            .font(.system(size: 30, weight: .bold, design: .monospaced))
                    }
                    
                    Spacer().frame(height: 2)
                    // Single description
                    Text("局部多云")
                    
                    Spacer().frame(height: 15)
                    
                    // Presure Huminity Wind
                    HStack{
                        HStack{
                            Image(systemName: "aqi.medium")
                            Text("720hpa")
                        }
                        Spacer()
                        HStack{
                            Image(systemName: "humidity")
                            Text("32%")
                        }
                        Spacer()
                        HStack{
                            Image(systemName: "wind")
                            Text("12km/h")
                        }
                    }
                    
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.secondary.cornerRadius(10))
                
                // Today Weather: Future hoursly
                VStack{
                    VStack{
                        // Title
                        HStack{
                            Text("今天")
                            Spacer()
                        }
                        // Horizontal Scroll
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 15){
                                ForEach(weathers, id: \.self){ weather in
                                    VStack{
                                        Text(weather)
                                            .font(.system(size: 14, weight: .bold))
                                        Spacer().frame(height: 7)
                                        Image(systemName: "moon.fill")
                                            .renderingMode(.template)
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.secondary)
                                            .scaledToFill()
                                        Spacer().frame(height: 7)
                                        Text("26º")
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    // Future daily weather
                    VStack{
                        ForEach(dailyWeahter, id:\.self){ weather in
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
                                Text(weather.temperture)
                                Spacer()
                                Image(systemName: weather.icon)
                            }.padding()
                        }
                    }
                }
                
            }
            .padding(.horizontal)
        }
    }
}

struct Temperature_Previews: PreviewProvider {
    static var previews: some View {
        Temperature()
    }
}
