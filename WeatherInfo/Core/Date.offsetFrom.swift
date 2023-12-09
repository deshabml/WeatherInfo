//
//  Date.offsetFrom.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import Foundation

extension Date {

    func offsetFrom(date: Date) -> String {
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)
        let seconds = "\(difference.second ?? 0)s"
        let minutes = "\(difference.minute ?? 0)m"
        let hours = "\(difference.hour ?? 0)h"
        let days = "\(difference.day ?? 0)d"
        if let day = difference.day, day          > 0 { return days }
        if let hour = difference.hour, hour       > 0 { return hours }
        if let minute = difference.minute, minute > 0 { return minutes }
        if let second = difference.second, second > 0 { return seconds }
        return ""
    }
}
