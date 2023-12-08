//
//  ParsingService.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation
import SwiftyJSON

class ParsingService {

    static let shared = ParsingService()

    private init() { }

    func users(from data: Data) -> [String]? {
        guard let json = try? JSON(data: data) else { return nil }
        var citys: [String] = []
        let jsons = json["suggestions"]
        for index in 0 ..< jsons.count {
            let city = jsons[index]["data"]["city"].stringValue
            if city.count > 0 {
                citys.append(city)
            }
        }
        return Array(Set(citys))
    }

    func statistics(from data: Data) -> [(min: Double, max: Double, pop: Int, utc: Int)]? {
        guard let json = try? JSON(data: data) else { return nil }
        var itog: [(min: Double, max: Double, pop: Int, utc: Int)] = []
        let jsons = json["daily"]
        for index in 0 ..< jsons.count {
            let min = jsons[index]["temp"]["min"].double ?? 0
            let max = jsons[index]["temp"]["max"].double ?? 0
            let pop = Int((jsons[index]["pop"].double ?? 0) * 100)
            let utc = jsons[index]["dt"].int ?? 0
            itog.append((min, max, pop, utc))
        }
        return itog
    }
}
