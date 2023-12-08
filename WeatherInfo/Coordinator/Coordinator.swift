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
    var hotelName: String = ""

    func goHome() {
        path.removeLast(path.count)
    }

    func goBack() {
        path.removeLast()
    }

    func goToWeatherSelectCity() {
        path.append(MyPage.weatherSelectCityView)
    }

    @ViewBuilder
    func getPage(_ page: MyPage) -> some View {
        switch page {
            case .weatherView:
                WeatherView(viewModel: WeatherViewModel())
            case .weatherSelectCityView:
                WeatherSelectCityView()
        }
    }
}

extension Coordinator {

//    func setupHotelName(hotelName: String) {
//        self.hotelName = hotelName
//    }

}
