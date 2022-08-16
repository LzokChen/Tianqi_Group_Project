//
//  SearchView.swift
//  ClimaWeather
//
//  Created by 刘峥炫 on 2022/8/16.
//

import SwiftUI
import Lottie

struct SearchView: View {
    
    @StateObject var cityLocation = CityLocation()

    @State var CurrentCity:String?
    @StateObject var locationViewModel = LocationViewModel()
    
    @State private var weatherManager = WeatherManager.shared
    
    @State var SearchContent:String = ""
    @State var SearchMode:Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        let binding = Binding<String>(get:{
            self.SearchContent
        },set:{
            self.SearchContent = $0
            if($0 != ""){
                cityLocation.search($0)
                SearchMode = true
            }else{
                SearchMode = false
            }
        })
        
        return NavigationView {
            List{
                
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("搜索城市", text: binding)
                }
                if(SearchMode){
                    ForEach(cityLocation.searchCitys, id:\.self){ city in
                        Button(city){
                            setWeatherCity(city)
                            dismiss()
                        }
                    }
                }else{
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
