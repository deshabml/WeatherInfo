//
//  WeatherViewModel.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation

final class WeatherViewModel: ObservableObject {

    @Published var weatherData: WeatherData?
    @Published var city: String = "" {
        didSet {
            checkCity(text: city)
        }
    }
    @Published var citys: [String] = []
    @Published var statistics: [(min: Double, max: Double, pop: Int, utc: Int)] = []
    @Published var statisticsByHour: [WeatherByHour] = []

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
                    self.getStatisticsByHour()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func getStatisticsByHour() {
        guard let weatherData else { return }
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

    func weatherDescriptionText() -> String {
        guard let weatherData, !weatherData.weather.isEmpty else {
            return "-"
        }
        return weatherData.weather[0].description
    }
}

