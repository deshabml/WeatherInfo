//
//  CityViewModel.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import Foundation

final class CityViewModel: ObservableObject {

    @Published var text: String = "-"

    func setupText(text: String) {
        self.text = text
    }
}
