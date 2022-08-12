//
//  WeatherDetail.swift
//  ClimaWeather
//
//  Created by 刘峥炫 on 2022/8/12.
//

import SwiftUI

struct WeatherDetailView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                // City Weather
                VStack{
                    Text("深圳市")
                        .font(.system(size: 35, weight: .bold, design: .monospaced))
                    Text("25º | 局部多云")
                        .fontWeight(.bold)
                }
                Spacer().frame(height: 35)
                VStack{
                    HStack{
                        DetailCard(icon: "sun.max.fill",detailText: "紫外线指数", detailDescripe: "0 低", singleDescripe:"")
                        DetailCard(icon: "sunrise",detailText: "日出", detailDescripe: "05:59", singleDescripe:"日落: 18:59")
                    }
                }
                VStack{
                    HStack{
                        DetailCard(icon: "wind",detailText: "风速", detailDescripe: "12m/s", singleDescripe:"")
                        DetailCard(icon: "cloud.drizzle",detailText: "降雨", detailDescripe: "1 毫米", singleDescripe:"预计未来24小时内有23毫米")
                    }
                }
                VStack{
                    HStack{
                        DetailCard(icon: "thermometer.low",detailText: "体感温度", detailDescripe: "30ºC", singleDescripe:"潮湿使人感觉更暖和")
                        DetailCard(icon: "humidity.fill",detailText: "湿度", detailDescripe: "93%", singleDescripe:"目前露点温度为24º")
                    }
                }
                VStack{
                    HStack{
                        DetailCard(icon: "eye",detailText: "能见度", detailDescripe: "8 公里", singleDescripe:"薄雾影响了能见度")
                        DetailCard(icon: "cloud.bolt.circle",detailText: "气压", detailDescripe: "1kPa", singleDescripe:"")
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
                    .font(.system(size: 35, weight: .heavy))
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
