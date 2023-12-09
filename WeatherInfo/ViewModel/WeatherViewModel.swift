//
//  WeatherViewModel.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation

final class WeatherViewModel: ObservableObject {

    @Published var weatherData: WeatherData = WeatherData.weatherDataClear
    @Published var city: String = "" {
        didSet {
            checkCity(text: city)
        }
    }
    @Published var citys: [String] = []
    @Published var statistics: [(min: Double, max: Double, pop: Int, utc: Int)] = []
    @Published var statisticsByHour: [WeatherByHour] = []
    let cityVM = CityViewModel()
    init() {
        loadFirstCity()
    }

    func loadFirstCity() {
        let locationService = LocationService()
        locationService.getCityName { [unowned self] cityName in
            city = cityName.localizedCapitalized
            getWeather()
        }
        print(city)
    }

    func getWeather() {
        Task {
            do {
                let data = try await NetworkServiceAA.shared.getWeatherData(city: city)
                DispatchQueue.main.async { [unowned self] in
                    self.weatherData = data
                    self.cityVM.setupText(text: weatherData.name)
                    self.getStatisticsByHour()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func getStatisticsByHour() {
        Task {
            do {
                let data = try await NetworkServiceAA.shared.getStatisticsByHour(weatherData: weatherData)
                DispatchQueue.main.async { [unowned self] in
                    self.statisticsByHour = data
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func checkCity(text: String) {
        Task {
            do {
                let data = try await NetworkServiceAA.shared.checkCity(city: CityQuery(query: text, count: 5))
                DispatchQueue.main.async { [unowned self] in
                    self.citys = data
                    print(self.citys)
                }
            } catch {
                print(error)
            }
        }
    }
}

