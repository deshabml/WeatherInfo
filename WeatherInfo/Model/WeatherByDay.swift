//
//  WeatherByDay.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import Foundation
import RealmSwift

final class WeatherByDay: Object {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var min: Double
    @Persisted var max: Double
    @Persisted var pop: Int
    @Persisted var utc: Int
    @Persisted var imageName: String

    convenience init(min: Double, max: Double, pop: Int, utc: Int, imageName: String) {
        self.init()
        self.min = min
        self.max = max
        self.pop = pop
        self.utc = utc
        self.imageName = imageName
    }
}
