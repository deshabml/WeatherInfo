//
//  WeatherViewModel.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation

final class WeatherViewModel: ObservableObject {

    @Published var weatherData: WeatherData?
    @Published var city: String = "" 
//    {
//        didSet {
//            checkCity(text: city)
//        }
//    }
    @Published var isChoosingCity = true
    @Published var citys: [String] = []
    @Published var statistics: [(min: Double, max: Double, pop: Int, utc: Int)] = []
    var isCityExists: Bool {
        citys.count > 0
    }

    init() {
        loadFirstCity()
    }

    func loadFirstCity() {
        let locationService = LocationService()
        locationService.getCityName { [unowned self] cityName in
            city = cityName
        }
        print(city)
    }
}

