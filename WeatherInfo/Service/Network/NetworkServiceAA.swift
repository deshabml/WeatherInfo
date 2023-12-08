//
//  NetworkServiceAA.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation

class NetworkServiceAA {

    static let shared = NetworkServiceAA()

    private init() { }

    func getWeatherData(city: String) async throws -> WeatherData {
        guard let url = URLManager.shared.createURL(city: city,
                                                    endpoint: .currentWeather) else { throw NetworkError.badUrl }
        let response = try await URLSession.shared.data(from: url)
        let data = response.0
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            return weatherData
        } catch {
            throw NetworkError.invalidDecoding
        }
    }
//
//    func checkCity(city: CityQuery) async throws -> [String] {
//        guard let url = URL(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address") else {  throw NetworkError.badUrl }
//        let encoder = JSONEncoder()
//        do {
//            let body = try encoder.encode(city)
//            do {
//                var req = URLRequest(url: url)
//                req.httpMethod = "POST"
//                req.setValue("application/json" ,forHTTPHeaderField: "Content-type")
//                req.setValue("application/json" ,forHTTPHeaderField: "Accept")
//                req.setValue("Token 224925d20efc9ab248696b162dfb8e4d70571825" ,forHTTPHeaderField: "Authorization")
//                req.httpBody = body
//                let response = try await URLSession.shared.data(for: req)
//                let data = response.0
//                guard let itog = ParsingService.shared.users(from: data) else { throw NetworkError.invalidDecoding }
//                return itog
//            } catch { throw error }
//        } catch { throw error }
//    }

    func getStatistics(weatherData: WeatherData) async throws -> [(min: Double, max: Double, pop: Int, utc: Int)] {
        guard let url = URLManager.shared.createOnecallURL(weatherData: weatherData, endpoint: .currentOnecall) else { throw NetworkError.badUrl }
        let response = try await URLSession.shared.data(from: url)
        let data = response.0
        guard let itog = ParsingService.shared.statisticsDaily(from: data) else { throw NetworkError.invalidDecoding }
        return itog
    }

    func getStatisticsByHour(weatherData: WeatherData) async throws -> [WeatherByHour] {
        guard let url = URLManager.shared.createOnecallURL(weatherData: weatherData, endpoint: .currentOnecall) else { throw NetworkError.badUrl }
        let response = try await URLSession.shared.data(from: url)
        let data = response.0
        guard let itog = ParsingService.shared.statisticsHourly(from: data) else { throw NetworkError.invalidDecoding }
        return itog
    }
}





