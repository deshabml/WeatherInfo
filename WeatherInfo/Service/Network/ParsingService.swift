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

//    func users(from data: Data) -> [String]? {
//        guard let json = try? JSON(data: data) else { return nil }
//        var citys: [String] = []
//        let jsons = json["suggestions"]
//        for index in 0 ..< jsons.count {
//            let city = jsons[index]["data"]["city"].stringValue
//            if city.count > 0 {
//                citys.append(city)
//            }
//        }
//        return Array(Set(citys))
//    }

    func statisticsDaily(from data: Data) -> [(min: Double, max: Double, pop: Int, utc: Int)]? {
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

    func statisticsHourly(from data: Data) -> [WeatherByHour]? {
        guard let json = try? JSON(data: data) else { return nil }
        var itog: [WeatherByHour] = []
        let jsons = json["hourly"]
        guard jsons.count > 7 else { return nil }
        for index in 0 ..< 7 {
            let dt = jsons[index]["dt"].doubleValue
            let date = Date(timeIntervalSince1970: dt)
            let dateString = "\(date)"
            let dateStringArray = dateString.components(separatedBy: " ")
            let dateHourStringArray = dateStringArray[1].components(separatedBy: ":")
            let hour: String = dateHourStringArray[0]
            let temp: Double = jsons[index]["temp"].doubleValue
            let imageName: String = jsons[index]["weather"][0]["icon"].stringValue
            itog.append(WeatherByHour(hour: hour,
                                      temp: temp,
                                      imageName: imageName))
        }
        return itog
    }
}
