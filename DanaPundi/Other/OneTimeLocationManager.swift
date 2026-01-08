//
//  OneTimeLocationManager.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/8.
//


import UIKit
import CoreLocation

final class OneTimeLocationManager: NSObject {
    
    static let shared = OneTimeLocationManager()
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var completion: (([String: String]) -> Void)?
    
    private override init() {
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
            showLocationDeniedAlert()
            completion([:])
            self.completion = nil
            
        @unknown default:
            completion([:])
            self.completion = nil
        }
    }
}

extension OneTimeLocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        } else if status == .denied || status == .restricted {
            showLocationDeniedAlert()
            completion?([:])
            completion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?([:])
        completion = nil
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
                self?.completion = nil
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
                "no": placemark.subAdministrativeArea ?? ""
            ]
            
            self.completion?(result)
            self.completion = nil
        }
    }
}

private extension OneTimeLocationManager {
    
    func showLocationDeniedAlert() {
        DispatchQueue.main.async {
            guard let topVC = UIApplication.shared.topViewController() else { return }
            
            let alert = UIAlertController(
                title: "定位权限已关闭",
                message: "请在系统设置中开启定位权限，否则无法获取位置信息。",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "取消", style: .cancel))
            
            alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(url)
            })
            
            topVC.present(alert, animated: true)
        }
    }
}

extension UIApplication {
    
    func topViewController(
        base: UIViewController? = UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    ) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController,
           let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
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
