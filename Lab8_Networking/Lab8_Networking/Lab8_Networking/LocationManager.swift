//
//  LocationManager.swift
//  Lab8_Networking
//
//  Created by Adeesh on 2024-07-18.
//

import UIKit
import CoreLocation

protocol LocationUpdateDelegate {
    func didUpdateLocation(location: CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    var locationUpdateDelegate: LocationUpdateDelegate?
    
    override private init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                self.locationUpdateDelegate?.didUpdateLocation(location: location)
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to find user's location: \(error.localizedDescription)")
        }
}
