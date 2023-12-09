//
//  Coordinator.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import SwiftUI

@MainActor
final class Coordinator: ObservableObject {

    @Published var path = NavigationPath()
    @Published var page: MyPage = .weatherView
    var selectedCity: String = ""

    func goHome() {
        path.removeLast(path.count)
    }

    func goBack() {
        path.removeLast()
    }

    func goToWeatherSelectCity(city: String) {
        setupSelectedCity(city: city)
        path.append(MyPage.weatherSelectCityView)
    }

    @ViewBuilder
    func getPage(_ page: MyPage) -> some View {
        switch page {
            case .weatherView:
                WeatherView(viewModel: WeatherViewModel())
            case .weatherSelectCityView:
                WeatherSelectCityView(viewModel: WeatherSelectCityViewModel())
        }
    }
}

extension Coordinator {

    func setupSelectedCity(city: String) {
        self.selectedCity = city
    }

    func tempDescription(_ temp: Double) -> String {
        guard temp != 0 else { return "-" }
        if let langStr = Locale.current.language.languageCode {
            print(langStr)
        }
        let res = "\(Int(temp - 273))°С"
        return res
    }

    func temperatureRange(weatherData: WeatherData) -> String {
        guard weatherData.name != "" else { return "-"}
        return "Max: " + tempDescription(weatherData.main.tempMax) + ", min: " + tempDescription(weatherData.main.tempMin)
    }

    func weatherDescriptionText(weatherData: WeatherData) -> String {
        guard !weatherData.weather.isEmpty else {
            return "-"
        }
        return weatherData.weather[0].description
    }
}
