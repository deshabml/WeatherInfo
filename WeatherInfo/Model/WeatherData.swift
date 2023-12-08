//
//  WeatherData.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation

struct WeatherData: Identifiable, Decodable {

    let id: Int
    let name: String
    let cod: Int
    let timezone: Int
    let dt: Int
    let visibility: Int
    let base: String
    let weather: [Weather]
    let clouds: Clouds
    let main: Main
    let coord: Coord
    let wind: Wind
    let sys: Sys

    struct Sys: Decodable {
        let sunrise: Int
        let sunset: Int
    }

    struct Weather: Identifiable, Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Clouds: Decodable {
        let all: Int
    }

    struct Coord: Decodable {
        let lat: Double
        let lon : Double
    }

    struct Main: Decodable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
        let seaLevel: Int?
        let grndLevel: Int?
    }

    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double?
    }

}
