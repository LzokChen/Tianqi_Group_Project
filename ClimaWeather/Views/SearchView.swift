//
//  SearchView.swift
//  ClimaWeather
//
//  Created by 刘峥炫 on 2022/8/16.
//

import SwiftUI
import Lottie

struct SearchView: View {
    
    @StateObject var cityLocation : CityLocation = CityLocation()
    @StateObject var locationViewModel = LocationViewModel()
    @State private var weatherManager = WeatherManager.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        return NavigationView {
            List{
                
                HStack{
                    Image(systemName: "magnifyingglass")
                    SearchTextField()
                }
                Section("当前所在城市"){
                    if let city = locationViewModel.CurCity{
                        Button(city){
                            setWeatherCity(city)
                            dismiss()
                        }
                    }else{
                        Text("无法获取当前所在城市")
                    }
                }
                ForEach(cityLocation.groupTitles, id:\.self){ cityTitle in
                    Section(cityTitle){
                        ForEach(cityLocation.cityGroups[cityTitle] ?? [], id:\.self){ city in
                            Button(city){
                                setWeatherCity(city)
                                dismiss()
                            }
                        }
                    }
                }
            }
            .foregroundColor(Color.primary)
            .listStyle(.insetGrouped)
        }
        .onAppear{
            locationViewModel.requestPermission()
            locationViewModel.manager.startUpdatingLocation()
        }
        .onDisappear{
            locationViewModel.manager.stopUpdatingLocation()
        }
        .toolbar(content: {
            ToolbarItemGroup{
                Button(action: {
                    dismiss()
                }, label: {
                    Text("取消")
                        .foregroundColor(Color.blue)
                })
            }
        })
        .environmentObject(cityLocation)
        .environmentObject(locationViewModel)
        
    }
        
    
    func setWeatherCity(_ city:String){
        let _ = weatherManager.fetchWeather(address: city, withLatest: true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct SearchTextField : View {
    @State var SearchContent:String = ""
    @EnvironmentObject var cityLocation : CityLocation
    var body: some View {
        let binding = Binding<String>(get:{
            self.SearchContent
        },set:{
            self.SearchContent = $0
            if($0 != ""){
                cityLocation.search($0)
                cityLocation.searchMode = true
            }
            else{
                cityLocation.searchMode = false
                cityLocation.back()
            }
        })
        
        return TextField("搜索城市", text: binding)            
    }
}
