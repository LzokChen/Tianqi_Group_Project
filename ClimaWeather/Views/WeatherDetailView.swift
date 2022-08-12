//
//  WeatherDetail.swift
//  ClimaWeather
//
//  Created by 刘峥炫 on 2022/8/12.
//

import SwiftUI

struct WeatherDetail:Hashable {
    let city : String
    let temperature: String
    let pressure: String
    let humidity: String
    let windSpeed: String
    let ultravioletIndex: String
    let sunRise: String
    let visibility: String
    let sunSet: String
    let realFeel: String
    let realFeelTip: String
}

struct WeatherDetailView: View, WeatherManagerDelegate {
    @State private var weatherDetail: WeatherDetail? = nil
    @State private var hasUpdatedWeatherDetail = false
    
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, weather: CurrentWeatherModel) {
        let uvi = (Int)(weather.uvi) ?? 0
        let uviDescription = (uvi <= 2 ? "最弱" : uvi <= 4 ? "弱" : uvi <= 6 ? "中等" : uvi <= 9 ? "强" : "很强")
        
        var visibility = (Double)(weather.vis) ?? 0
        visibility = round(visibility / 100) / 10.0
        let visibilityDescription = (String)(visibility) + "公里"
        
        let pressure = (Double)(weather.pressure) ?? 0
        let pressureDescription = String(Int(round(pressure / 10))) + "kPa"
        
        weatherDetail = WeatherDetail(city: weather.secondaryName,
                                      temperature: weather.temperature + "º | " + weather.condition,
                                      pressure: pressureDescription,
                                      humidity: weather.humidity + "%",
                                      windSpeed: weather.windSpeed + "m/s",
                                      ultravioletIndex: weather.uvi + " " + uviDescription,
                                      sunRise: String(weather.sunRise.components(separatedBy: " ")[1].prefix(5)),
                                      visibility: visibilityDescription,
                                      sunSet: String(weather.sunSet.components(separatedBy: " ")[1].prefix(5)),
                                      realFeel: weather.realFeel + "º",
                                      realFeelTip: weather.tips
        )
        hasUpdatedWeatherDetail = true
        print(weatherDetail ?? "")
    }
    
    var body: some View {
        //MARK: - Usage: create weatherManager and setup the delegate
        let wm = WeatherManager()
        let _ = wm.setDelegate(delegate: self)
        
        if (!hasUpdatedWeatherDetail) {
            //let _ = wm.fetchCurrentWeather(latitude: 22.555259, longitude: 113.88402)
            let _ = wm.fetchCurrentWeather(address: "上海")
        }
        
        if (!hasUpdatedWeatherDetail) {
            VStack{
                LottieView(lottieFile: "load.json")
                    .frame(width: 300, height: 300)
                Text("Fetching the weather details...")
                    .frame(alignment: .center)
            }
        } else {
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    // City Weather
                    VStack{
                        Text(weatherDetail?.city ?? "Unknown City")
                            .font(.system(size: 35, weight: .bold, design: .monospaced))
                        Text(weatherDetail?.temperature ?? " ")
                            .fontWeight(.bold)
                    }
                    Spacer().frame(height: 35)
                    VStack{
                        HStack{
                            DetailCard(icon: "sun.max.fill",detailText: "紫外线指数", detailDescripe: (weatherDetail?.ultravioletIndex ?? "N/A"), singleDescripe:"")
                            DetailCard(icon: "sunrise",detailText: "日出", detailDescripe: (weatherDetail?.sunRise ?? "N/A"), singleDescripe:"日落: " + (weatherDetail?.sunSet ?? "N/A"))
                        }
                    }
                    VStack{
                        HStack{
                            DetailCard(icon: "wind",detailText: "风速", detailDescripe: (weatherDetail?.windSpeed ?? "N/A"), singleDescripe:"")
                            DetailCard(icon: "cloud.drizzle",detailText: "降雨", detailDescripe: "1 毫米", singleDescripe:"预计未来24小时内有23毫米")
                        }
                    }
                    VStack{
                        HStack{
                            DetailCard(icon: "thermometer.low", detailText: "体感温度", detailDescripe: (weatherDetail?.realFeel ?? "N/A"), singleDescripe: (weatherDetail?.realFeelTip ?? "N/A"))
                            DetailCard(icon: "humidity.fill", detailText: "湿度", detailDescripe: (weatherDetail?.humidity ?? "N/A"), singleDescripe: "")
                        }
                    }
                    VStack{
                        HStack{
                            DetailCard(icon: "eye", detailText: "能见度", detailDescripe: (weatherDetail?.visibility ?? "N/A"), singleDescripe: "")
                            DetailCard(icon: "cloud.bolt.circle", detailText: "气压", detailDescripe: (weatherDetail?.pressure ?? "N/A"), singleDescripe: "")
                        }
                    }
                }
            }
        }
    }
}

struct WeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView()
    }
}

struct DetailCard: View {
    let icon:String
    let detailText:String
    let detailDescripe:String
    let singleDescripe:String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: icon)
                    Text(detailText)
                }
                Spacer().frame(height: 10)
                Text(detailDescripe)
                    .font(.system(size: 28, weight: .heavy))
                Spacer()
                Text(singleDescripe)
            }
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width/2*0.80, height: UIScreen.main.bounds.width/2*0.80)
        .background(Color.secondary.opacity(0.3).cornerRadius(15))
        .foregroundColor(.secondary)
    }
}
