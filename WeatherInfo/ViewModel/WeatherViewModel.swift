//
//  WeatherViewModel.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import Foundation

final class WeatherViewModel: ObservableObject {

    @Published var weatherData: WeatherData?
    @Published var city: String = "" {
        didSet {
            checkCity(text: city)
        }
    }
    @Published var isChoosingCity = true
    @Published var citys: [String] = []
    @Published var statistics: [(min: Double, max: Double, pop: Int, utc: Int)] = []
    @Published var statisticsByHour: [WeatherByHour] = [] 

    var isCityExists: Bool {
        citys.count > 0
    }

    init() {
        loadFirstCity()
    }

    func loadFirstCity() {
        let locationService = LocationService()
        locationService.getCityName { [unowned self] cityName in
            city = cityName.localizedCapitalized
            getWeather()
        }
        print(city)
    }

    func getWeather() {
        Task {
            do {
                let data = try await NetworkServiceAA.shared.getWeatherData(city: city)
                DispatchQueue.main.async { [unowned self] in
                    self.weatherData = data
                    self.getStatisticsByHour()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func getStatisticsByHour() {
        guard let weatherData else { return }
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

    func checkCity(text: String) {
//        DataService.shared.saveCity(city)
        Task {
            do {
                let data = try await NetworkServiceAA.shared.checkCity(city: CityQuery(query: text, count: 5))
                DispatchQueue.main.async { [unowned self] in
                    self.citys = data
                    print(self.citys)
                }
            } catch {
                print(error)
            }
        }
    }




//    func currentTime() {
//        let date = NSDate()
////        print(date)
//        let unidate = date.timeIntervalSince1970
////        let calendar = NSCalendar.current
////        let components = calendar.component(.year, from: .now)
////        print(components)
//        let dateTwo = NSDate(timeIntervalSince1970: 1702058400)
////        print(unidate)
////        print(unidate)
//        print(dateTwo)
////
////        let isoDate = "2016-04-14T10:44:00+0000"
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
////        let currentDate = Date().description
//
////        let formattedDate = dateFormatter.string(from: currentDate)
////print(currentDate)
////        print(formattedDate)
////        let date2 = dateFormatter.date(from: <#T##String#>)
////        print(date/*2)*/
////        let dateTwo2 = NSDate(timeIntervalSince1970: 1702049040)
////        print(dateTwo2)
////        let dateTwo3 = NSDate(timeIntervalSince1970: 1702049100)
////        print(dateTwo3)
////        let dateTwo4 = NSDate(timeIntervalSince1970: 1702049160)
////        print(dateTwo4)
// 
//
////            .components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
////        let hour = components.hour
////        let minutes = components.minute
//    }

    func tempDescription(_ temp: Double?) -> String {
        guard let temp else {
            return "-"
        }
        if let langStr = Locale.current.language.languageCode {
            print(langStr)
        }
        let res = "\(Int(temp - 273))°С"
        return res
    }

    func temperatureRange() -> String {
        "Max: " + tempDescription(weatherData?.main.tempMax) + ", min: " + tempDescription(weatherData?.main.tempMin)
    }

    func weatherDescriptionText() -> String {
        guard let weatherData, !weatherData.weather.isEmpty else {
            return "-"
        }
        return weatherData.weather[0].description
    }
}

