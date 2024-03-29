//
//  WeatherViewModel.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation

final class WeatherViewModel: ObservableObject {

    @Published var weatherData: WeatherData = WeatherData.weatherDataClear
    @Published var city: String = "" {
        didSet {
            checkCity(text: city)
        }
    }
    @Published var citys: [String] = []
    @Published var statisticsByDay: [WeatherByDay] = []
    @Published var statisticsByHour: [WeatherByHour] = []
    let cityVM = CityViewModel()

    init() {
        if NetworkMonitor.shared.isConnected {
            loadFirstCity()
        } else {
            getData()
        }
    }

    func loadFirstCity() {
        let locationService = LocationService()
        locationService.getCityName { [unowned self] cityName in
            city = cityName.localizedCapitalized
            getWeather()
        }
    }

    func getWeather() {
        Task {
            do {
                let data = try await NetworkServiceAA.shared.getWeatherData(city: city)
                DispatchQueue.main.async { [unowned self] in
                    self.weatherData = data
                    self.cityVM.setupText(text: weatherData.name)
                    self.getStatisticsByHour()
                    self.getStatisticsByDay()
                    self.saveWeatherDataData()
                    self.saveDateLastSave()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func getStatisticsByHour() {
        Task {
            do {
                let data = try await NetworkServiceAA.shared.getStatisticsByHour(weatherData: weatherData)
                DispatchQueue.main.async { [unowned self] in
                    self.statisticsByHour = data
                    self.saveWeatherByHourData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func getStatisticsByDay() {
        Task {
            do {
                let data = try await NetworkServiceAA.shared.getStatisticsByDay(weatherData: weatherData)
                DispatchQueue.main.async { [unowned self] in
                    self.statisticsByDay = data
                    self.saveWeatherByDayData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func checkCity(text: String) {
        Task {
            do {
                let data = try await NetworkServiceAA.shared.checkCity(city: CityQuery(query: text, count: 5))
                DispatchQueue.main.async { [unowned self] in
                    self.citys = data
                }
            } catch {
                print(error)
            }
        }
    }

    func saveWeatherDataData() {
        let weatherDatas = RealmService.shared.getWeatherData()
        if weatherDatas.isEmpty {
            RealmService.shared.createObject(object: weatherData)
        } else {
            RealmService.shared.updateObject(oldObject: weatherDatas[0],
                                             newObject: weatherData)
        }
    }

    func saveWeatherByHourData() {
        let weatherByHourDatas = RealmService.shared.getWeatherByHour()
        if weatherByHourDatas.isEmpty {
            statisticsByHour.forEach { weatherByHour in
                RealmService.shared.createObject(object: weatherByHour)
            }
        } else {
            for index in 0 ..< statisticsByHour.count {
                RealmService.shared.updateObject(oldObject: weatherByHourDatas[index],
                                                 newObject: statisticsByHour[index])
            }
        }
    }

    func saveWeatherByDayData() {
        let weatherByDayDatas = RealmService.shared.getWeatherByDay()
        if weatherByDayDatas.isEmpty {
            statisticsByDay.forEach { weatherByDay in
                RealmService.shared.createObject(object: weatherByDay)
            }
        } else {
            for index in 0 ..< statisticsByDay.count {
                RealmService.shared.updateObject(oldObject: weatherByDayDatas[index],
                                                 newObject: statisticsByDay[index])
            }
        }
    }

    func saveDateLastSave() {
        let currentDate = Date()
        let currentDateLastSave = DateLastSave(date: currentDate)
        let dateLastSaveDatas = RealmService.shared.getDataLastSave()
        if dateLastSaveDatas.isEmpty {
            RealmService.shared.createObject(object: currentDateLastSave)
        } else {
            RealmService.shared.updateObject(oldObject: dateLastSaveDatas[0],
                                             newObject: currentDateLastSave)
        }
    }

    func dataRelevanceInterval() -> String {
        let dateLastSaveDatas = RealmService.shared.getDataLastSave()
        guard !dateLastSaveDatas.isEmpty else { return "-" }
        let dateLastSave = dateLastSaveDatas[0]
        let currentDate = Date()
        return currentDate.offsetFrom(date: dateLastSave.date) + " " + "ago".localized
    }


    func getData() {
        let weatherDatas = RealmService.shared.getWeatherData()
        if !weatherDatas.isEmpty {
            self.weatherData = weatherDatas[0]
        }
        self.statisticsByHour = RealmService.shared.getWeatherByHour()
        self.statisticsByDay = RealmService.shared.getWeatherByDay()
        self.cityVM.setupText(text: weatherData.name)
    }

    func minStatistic() -> Double {
        var min = statisticsByDay[0].min
        for index in 0 ..< statisticsByDay.count {
            if statisticsByDay[index].min < min {
                min = statisticsByDay[index].min
            }
        }
        return min
    }

    func maxStatistic() -> Double {
        var max = statisticsByDay[0].max
        for index in 0 ..< statisticsByDay.count {
            if statisticsByDay[index].max > max {
                max = statisticsByDay[index].max
            }
        }
        return max
    }

    func widthDeyTemp(index: Int) -> Double {
        let ratio = (maxStatistic() - minStatistic()) / (statisticsByDay[index].max - statisticsByDay[index].min)
        return 100 / ratio
    }

    func weekDay(index: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(statisticsByDay[index].utc))
        let celendar = Calendar.current
        let weekDayNumber = celendar.component(.weekday, from: date)
        let weekDays = ["",
                        "sunday".localized,
                        "monday".localized,
                        "tuesday".localized,
                        "wednesday".localized,
                        "thursday".localized,
                        "friday".localized,
                        "saturday".localized]
        return weekDays[weekDayNumber]
    }

    func paddingTemp(index: Int) -> Double {
        let oneDegree = 100 / (maxStatistic() - minStatistic())
        return (statisticsByDay[index].min - minStatistic()) * oneDegree
    }
}
