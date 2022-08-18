//
//  WeatherDetail.swift
//  ClimaWeather
//
//  Created by 刘峥炫 on 2022/8/12.
//
import SwiftUI
import SDWebImageSwiftUI

struct WeatherDetail:Hashable {
    let updateTime : String
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
    let qpf : String
}

/* The View for "实时天气" screen. */
struct WeatherDetailView: View, WeatherManagerDelegate {

    
    @State private var weatherDetail: WeatherDetail? = nil
    @State private var weatherManager = WeatherManager.shared
    @State private var hasUpdateWeather = false
    
    /* Fetch current weather details */
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        let curWeather = weather.current
        let uvi = (Int)(curWeather.uvi) ?? 0
        let uviDescription = (uvi <= 2 ? "最弱" : uvi <= 4 ? "弱" : uvi <= 6 ? "中等" : uvi <= 9 ? "强" : "很强")
        
        // Convert the unit of weather.vis from m to km and round to keep 1 decimal place
        var visibility = (Double)(curWeather.vis) ?? 0
        visibility = round(visibility / 100) / 10.0
        let visibilityDescription = (String)(visibility) + "公里"
        
        // Convert the unit of weather.pressure from hpa to kpa and round to nearest Int
        let pressure = (Double)(curWeather.pressure) ?? 0
        let pressureDescription = String(Int(round(pressure / 10))) + "kPa"
        
        let updateDateTime = weather.updateTime
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        weatherDetail = WeatherDetail(updateTime: formatter.string(from: updateDateTime),
                                      city: weather.city.secondaryName + " " + weather.city.name,
                                      temperature: curWeather.temp + "º | " + curWeather.condition,
                                      pressure: pressureDescription,
                                      humidity: curWeather.humidity + "%",
                                      windSpeed: curWeather.windSpeed + "m/s",
                                      ultravioletIndex: curWeather.uvi + " " + uviDescription,
                                      sunRise: String(curWeather.sunRise.components(separatedBy: " ")[1].prefix(5)),
                                      visibility: visibilityDescription,
                                      sunSet: String(curWeather.sunSet.components(separatedBy: " ")[1].prefix(5)),
                                      realFeel: curWeather.realFeel + "º",
                                      realFeelTip: curWeather.tips,
                                      qpf: weather.hourlyForecasts[0].qpf + "毫米"
        )
        hasUpdateWeather = true
    }
    
    var body: some View {
        //MARK: - Usage: create weatherManager and setup the delegate
        
        let _ = weatherManager.addDelegate(with: self)
        
        if (!hasUpdateWeather) {
            let _ = weatherManager.fetchWeather(address: weatherDetail?.city ?? "上海", withLatest: false)
        }
        
        // When data hasn't been fetched, show the loading animation.
        if (!hasUpdateWeather) {
            VStack{
                LottieView(lottieFile: "load.json")
                    .frame(width: 300, height: 180)
                Text("Fetching the weather details...")
                    .frame(alignment: .center)
            }
        } else {
            RefreshableScrollView {
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        // City Weather
                        VStack{
                            Text(weatherDetail?.city ?? "Unknown City")
                                .font(.system(size: 35, weight: .bold, design: .monospaced))
                            Text(weatherDetail?.temperature ?? " ")
                                .fontWeight(.bold)
                            Spacer()
                            Text("更新时间:"+(weatherDetail?.updateTime ?? "Unknown Time"))
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
                                DetailCard(icon: "cloud.drizzle",detailText: "降雨", detailDescripe: (weatherDetail?.qpf ?? "N/A"), singleDescripe:"预计未来24小时内有\(weatherDetail?.qpf ?? "N/A")")
                            }
                        }
                        VStack{
                            HStack{
                                DetailCard(icon: "thermometer", detailText: "体感温度", detailDescripe: (weatherDetail?.realFeel ?? "N/A"), singleDescripe: (weatherDetail?.realFeelTip ?? "N/A"))
                                DetailCard(icon: "humidity.fill", detailText: "湿度", detailDescripe: (weatherDetail?.humidity ?? "N/A"), singleDescripe: "")
                            }
                        }
                        VStack{
                            HStack{
                                DetailCard(icon: "eye", detailText: "能见度", detailDescripe: (weatherDetail?.visibility ?? "N/A"), singleDescripe: "")
                                DetailCard(icon: "cloud", detailText: "气压", detailDescripe: (weatherDetail?.pressure ?? "N/A"), singleDescripe: "")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            } onRefresh: {
                // Fetch all data again when user pulls to refresh the screen.
                let _ = weatherManager.fetchWeather(address: weatherDetail?.city ?? "上海", withLatest: true)
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
                        .fontWeight(.bold)
                }
                Spacer().frame(height: 10)
                Text(detailDescripe)
                    .font(.system(size: 28, weight: .heavy))
                Spacer()
                Text(singleDescripe)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width/2*0.80, height: UIScreen.main.bounds.width/2*0.80)
        .background(Color.secondary.opacity(0.5).cornerRadius(15))
        .foregroundColor(.white)
    }
}
