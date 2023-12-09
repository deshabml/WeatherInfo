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

    static var weatherDataClear = WeatherData(id: 0,
                                              name: "-",
                                              cod: 0,
                                              timezone: 0,
                                              dt: 0,
                                              visibility: 0,
                                              base: "-",
                                              weather: [],
                                              clouds: Clouds(all: 0),
                                              main: Main(temp: 0,
                                                         feelsLike: 0,
                                                         tempMin: 0,
                                                         tempMax: 0,
                                                         pressure: 0,
                                                         humidity: 0,
                                                         seaLevel: 0,
                                                         grndLevel: 0),
                                              coord: Coord(lat: 0,
                                                           lon: 0),
                                              wind: Wind(speed: 0,
                                                         deg: 0,
                                                         gust: 0),
                                              sys: Sys(sunrise: 0,
                                                       sunset: 0))
}
