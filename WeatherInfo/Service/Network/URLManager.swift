//
//  URLManager.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation

enum Endpoint: String {
    
    case currentWeather = "/data/2.5/weather"
    case currentOnecall = "/data/2.5/onecall?"
}

class URLManager {

    static let shared = URLManager()

    private init() {}

    private let apiKey = "b9c81050cef9855eeaca27cf97ae5d26"
    private let gateway = "https://"
    private let server = "api.openweathermap.org"

    func createURL(city: String, endpoint: Endpoint) -> URL? {
        var str = gateway + server + endpoint.rawValue
        str += "?appid=\(apiKey)&q=\(city)"
        let url = URL(string: str)
        return url
    }

//    func createOnecallURL(weatherData: WeatherData, endpoint: Endpoint) -> URL? {
//        let lat = "lat=" + String(format: "%.4f", weatherData.coord.lat)
//        let lon = "lon=" + String(format: "%.4f", weatherData.coord.lon)
//        var str = gateway + server + endpoint.rawValue + lat + "&" + lon
//        str += "&appid=\(apiKey)"
//        let url = URL(string: str)
//        return url
//    }
}
