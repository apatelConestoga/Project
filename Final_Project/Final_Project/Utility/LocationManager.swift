//
//  LocationManager.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-11.
//

import UIKit
import CoreLocation
import MapKit

protocol LocationUpdateDelegate {
    func didUpdateLocation(locations: CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    
    var locationUpdateDelegate: LocationUpdateDelegate?
    
    override private init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization() 
        self.locationManager.requestLocation()
        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.startUpdatingLocation()
//        }
    }

    func stopTrip() {
        self.locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        self.locationUpdateDelegate?.didUpdateLocation(locations: newLocation)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}


