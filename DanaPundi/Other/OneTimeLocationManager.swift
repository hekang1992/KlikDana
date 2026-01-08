//
//  OneTimeLocationManager.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/8.
//

import UIKit
import CoreLocation

class OneTimeLocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var completion: (([String: String]) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func locateOnce(completion: @escaping ([String: String]) -> Void) {
        self.completion = completion
        
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            
        case .denied, .restricted:
            completion([:])
            
            
        @unknown default:
            completion([:])
        }
    }
}

extension OneTimeLocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        } else if status == .denied || status == .restricted {
            completion?([:])
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?([:])
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let lat = String(location.coordinate.latitude)
        let lon = String(location.coordinate.longitude)
        
        LocationStorage.save(lat: lat, lon: lon)
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, _ in
            guard let self = self,
                  let placemark = placemarks?.first else {
                self?.completion?([:])
                return
            }
            
            let result: [String: String] = [
                "findenne": placemark.administrativeArea ?? "",
                "tractature": placemark.isoCountryCode ?? "",
                "cusp": placemark.country ?? "",
                "collegeish": placemark.name ?? "",
                "stultiia": "\(lat)",
                "violenceitude": "\(lon)",
                "structard": placemark.locality ?? "",
                "national": placemark.subLocality ?? "",
                "no": placemark.subLocality ?? ""
            ]
            
            self.completion?(result)
        }
    }
}

final class LocationStorage {
    
    private static let latKey = "lat"
    private static let lonKey = "lon"
    
    static func save(lat: String, lon: String) {
        UserDefaults.standard.set(lat, forKey: latKey)
        UserDefaults.standard.set(lon, forKey: lonKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getLat() -> String? {
        UserDefaults.standard.string(forKey: latKey)
    }
    
    static func getLon() -> String? {
        UserDefaults.standard.string(forKey: lonKey)
    }
    
}
