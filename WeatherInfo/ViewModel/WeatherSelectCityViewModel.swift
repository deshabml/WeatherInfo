//
//  WeatherSelectCityViewModel.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import Foundation

final class WeatherSelectCityViewModel: ObservableObject {

    @Published var weatherData: WeatherData = WeatherData.weatherDataClear
    let cityVM = CityViewModel()

    func getWeather(city: String) {
        Task {
            do {
                let data = try await NetworkServiceAA.shared.getWeatherData(city: city)
                DispatchQueue.main.async { [unowned self] in
                    self.weatherData = data
                    self.cityVM.setupText(text: weatherData.name)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
