//
//  RealmService.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import Foundation
import RealmSwift

class RealmService {

    static let shared = RealmService()
    private let dataBase = try! Realm()

    private init() { }

    func createObject<T>(object: T) {
        guard let object = object as? Object else { return }
        do {
            try dataBase.write {
                dataBase.add(object)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func updateObject<T>(oldObject: T, newObject: T) {
        if let oldObject = oldObject as? WeatherData, let newObject = newObject as? WeatherData {
            do {
                try dataBase.write {
                    oldObject.name = newObject.name
                    oldObject.mainTemp = newObject.mainTemp
                    oldObject.mainTempMin = newObject.mainTempMin
                    oldObject.mainTempMax = newObject.mainTempMax
                    oldObject.weatherDescription = newObject.weatherDescription
                    oldObject.weatherIcon = newObject.weatherIcon
                    oldObject.coordLat = newObject.coordLat
                    oldObject.coordLon = newObject.coordLon
                }
            } catch {
                print("Неисправность базы данных")
            }
        }
        if let oldObject = oldObject as? WeatherByHour, let newObject = newObject as? WeatherByHour {
            do {
                try dataBase.write {
                    oldObject.hour = newObject.hour
                    oldObject.temp = newObject.temp
                    oldObject.imageName = newObject.imageName
                }
            } catch {
                print("Неисправность базы данных")
            }
        }
        if let oldObject = oldObject as? WeatherByDay, let newObject = newObject as? WeatherByDay {
            do {
                try dataBase.write {
                    oldObject.min = newObject.min
                    oldObject.max = newObject.max
                    oldObject.pop = newObject.pop
                    oldObject.utc = newObject.utc
                    oldObject.imageName = newObject.imageName
                }
            } catch {
                print("Неисправность базы данных")
            }
        }
        if let oldObject = oldObject as? DateLastSave, let newObject = newObject as? DateLastSave {
            do {
                try dataBase.write {
                    oldObject.date = newObject.date
                }
            } catch {
                print("Неисправность базы данных")
            }
        }
    }

    func deleteObject<T>(object: T) {
        guard let object = object as? Object else { return }
        do {
            try dataBase.write {
                dataBase.delete(object)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func getWeatherData() -> [WeatherData] {
        let weatherDataList = dataBase.objects(WeatherData.self)
        var weatherDatas = [WeatherData]()
        for weatherData in weatherDataList {
            weatherDatas.append(weatherData)
        }
        return weatherDatas
    }

    func getWeatherByHour() -> [WeatherByHour] {
        let weatherByHourList = dataBase.objects(WeatherByHour.self)
        var weatherByHours = [WeatherByHour]()
        for weatherByHour in weatherByHourList {
            weatherByHours.append(weatherByHour)
        }
        return weatherByHours
    }

    func getWeatherByDay() -> [WeatherByDay] {
        let weatherByDayList = dataBase.objects(WeatherByDay.self)
        var weatherByDays = [WeatherByDay]()
        for weatherByDay in weatherByDayList {
            weatherByDays.append(weatherByDay)
        }
        return weatherByDays
    }

    func getDataLastSave() -> [DateLastSave] {
        let dateLastSaveList = dataBase.objects(DateLastSave.self)
        var dateLastSaves = [DateLastSave]()
        for dateLastSave in dateLastSaveList {
            dateLastSaves.append(dateLastSave)
        }
        return dateLastSaves
    }
}
