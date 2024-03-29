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

    init() {
        NetworkMonitor.shared.startMonitoring()
    }

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
        let tempC = Int(temp - 273)
        let tempF = Int((temp - 273) * 1.8 + 32)
        let res = ("language".localized == "язык") ? "\(tempC)°С" : "\(tempF)°F"
        return res
    }

    func temperatureRange(weatherData: WeatherData) -> String {
        guard weatherData.name != "" else { return "-"}
        return "max".localized + ": " + tempDescription(weatherData.mainTempMax) + ", " + "min".localized + ": " + tempDescription(weatherData.mainTempMin)
    }
}
