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
        loadFirstCity()
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
        return 140 / ratio
    }

    func weekDay(index: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(statisticsByDay[index].utc))
        let celendar = Calendar.current
        let weekDayNumber = celendar.component(.weekday, from: date)
        let weekDays = ["", "ВС", "ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"]
        return weekDays[weekDayNumber]
    }

    func paddingTemp(index: Int) -> Double {
        let oneDegree = 140 / (maxStatistic() - minStatistic())
        return (statisticsByDay[index].min - minStatistic()) * oneDegree
    }
}

