//
//  WeatherByHour.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation
import RealmSwift

final class WeatherByHour: Object {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var hour: String
    @Persisted var temp: Double
    @Persisted var imageName: String

    convenience init(hour: String, temp: Double, imageName: String) {
        self.init()
        self.hour = hour
        self.temp = temp
        self.imageName = imageName
    }
}
