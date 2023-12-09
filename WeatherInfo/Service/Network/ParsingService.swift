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

    func city(from data: Data) -> [String]? {
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

    func weatherData(from data: Data) -> WeatherData? {
        guard let json = try? JSON(data: data) else { return nil }
        print(json)
        let name = json["name"].stringValue
        let mainTemp = json["main"]["temp"].doubleValue
        let mainTempMin = json["main"]["temp_min"].doubleValue
        let mainTempMax = json["main"]["temp_max"].doubleValue
        let weatherDescription = json["weather"][0]["description"].stringValue
        let weatherIcon = json["weather"][0]["icon"].stringValue
        let coordLat = json["coord"]["lat"].doubleValue
        let coordLon = json["coord"]["lon"].doubleValue
        return WeatherData(name: name,
                           mainTemp: mainTemp,
                           mainTempMin: mainTempMin,
                           mainTempMax: mainTempMax,
                           weatherDescription: weatherDescription,
                           weatherIcon: weatherIcon,
                           coordLat: coordLat,
                           coordLon: coordLon)
    }

    func statisticsDaily(from data: Data) -> [WeatherByDay]? {
        guard let json = try? JSON(data: data) else { return nil }
        var itog: [WeatherByDay] = []
        let jsons = json["daily"]
        for index in 0 ..< jsons.count {
            let min = jsons[index]["temp"]["min"].double ?? 0
            let max = jsons[index]["temp"]["max"].double ?? 0
            let pop = Int((jsons[index]["pop"].double ?? 0) * 100)
            let utc = jsons[index]["dt"].int ?? 0
            let imageName = jsons[index]["weather"][0]["icon"].stringValue
            itog.append(WeatherByDay(min: min,
                                     max: max,
                                     pop: pop,
                                     utc: utc,
                                     imageName: imageName))
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
