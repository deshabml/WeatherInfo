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
        locationManager.startUpdatingLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
            self.locationManager.stopUpdatingLocation()
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
                DispatchQueue.main.async {
                    self.completion?(city)
                }
            }
        }
    }
}
