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
//        getData()
    }

    func loadFirstCity() {
        let locationService = LocationService()
        locationService.getCityName { [unowned self] cityName in
            city = cityName
            getData()
        }
        print(city)
    }

    func getData() {
        Task {
            do {
                let data = try await NetworkServiceAA.shared.getWeatherData(city: city)
//                let statisticData = try await NetworkServiceAA.shared.getStatistics(weatherData: data)
                DispatchQueue.main.async { [unowned self] in
                    self.weatherData = data
                    print(weatherData?.weather.description)
//                    self.statistics = statisticData
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func tempDescription(_ temp: Double?) -> String {
        guard let temp else {
            return "-"
        }
        if let langStr = Locale.current.language.languageCode {
            print(langStr)
        }
        let res = "\(Int(temp - 273))°С"
        return res
    }

    func temperatureRange() -> String {
        "Max: " + tempDescription(weatherData?.main.tempMax) + ", min: " + tempDescription(weatherData?.main.tempMin)
    }

}

