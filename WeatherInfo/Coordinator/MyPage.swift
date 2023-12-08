//
//  MyPage.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import Foundation

enum MyPage: String, CaseIterable, Identifiable {

    case WeatherView, WeatherSelectCity

    var id: String {self.rawValue}
}
