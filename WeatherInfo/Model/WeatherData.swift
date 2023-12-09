//
//  WeatherData.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation
import RealmSwift

final class WeatherData: Object {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var mainTemp: Double
    @Persisted var mainTempMin: Double
    @Persisted var mainTempMax: Double
    @Persisted var weatherDescription: String
    @Persisted var weatherIcon: String
    @Persisted var coordLat: Double
    @Persisted var coordLon: Double

    convenience init(name: String, mainTemp: Double, mainTempMin: Double, mainTempMax: Double, weatherDescription: String, weatherIcon: String, coordLat: Double, coordLon: Double) {
        self.init()
        self.name = name
        self.mainTemp = mainTemp
        self.mainTempMin = mainTempMin
        self.mainTempMax = mainTempMax
        self.weatherDescription = weatherDescription
        self.weatherIcon = weatherIcon
        self.coordLat = coordLat
        self.coordLon = coordLon
    }

    static var weatherDataClear = WeatherData(name: "-",
                                              mainTemp: 0,
                                              mainTempMin: 0,
                                              mainTempMax: 0,
                                              weatherDescription: "-",
                                              weatherIcon: "",
                                              coordLat: 0,
                                              coordLon: 0)
}
