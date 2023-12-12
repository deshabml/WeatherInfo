//
//  LocationService.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import CoreLocation

class LocationService: NSObject {

    private var locationManager = CLLocationManager()
    private var completion: ((String) -> ())?
    private var isSuccess: Bool = false

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LocationService: CLLocationManagerDelegate {

    func getCityName(completion: @escaping (String) -> ()) {
        self.completion = completion
        getLocation()
    }

    func getLocation() {
        locationManager.startUpdatingLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.locationManager.stopUpdatingLocation()
            if !self.isSuccess {
                self.getLocation()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (mark, error) in
            guard let mark = mark?.first, error == nil else {
                return
            }
            if let city = mark.locality {
                DispatchQueue.main.async { [unowned self] in
                    self.completion?(city)
                    self.isSuccess = true
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
