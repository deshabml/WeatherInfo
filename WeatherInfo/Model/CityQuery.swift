//
//  CityQuery.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation

struct CityQuery: Encodable {

    let query: String
    let count: Int
    let language: String = "en"
}
