//
//  DataLastSave.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import Foundation
import RealmSwift

final class DateLastSave: Object {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var date: Date
    
    convenience init(date: Date) {
        self.init()
        self.date = date
    }
}
