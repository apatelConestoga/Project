import UIKit
import CoreLocation
import MapKit

protocol LocationUpdateDelegate {
    func didUpdateLocation(locations: [CLLocation])
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    private var locations: [CLLocation] = []
    var currentSpeed: Double = 0
    var maxSpeed: Double = 0
    var totalDistance: Double = 0
    var maxAcceleration: Double = 0
    private var totalSpeed: Double = 0
    private var speedCount: Int = 0
    var customSpeedLimit: Double = 115
    var averageSpeed: Double {
        return speedCount == 0 ? 0 : totalSpeed / Double(speedCount)
    }

    var locationUpdateDelegate: LocationUpdateDelegate?
    
    override private init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }

    func startTrip() {
        self.locations.removeAll()
        self.currentSpeed = 0
        self.maxSpeed = 0
        self.totalDistance = 0
        self.maxAcceleration = 0
        self.totalSpeed = 0
        self.speedCount = 0
        self.locationManager.startUpdatingLocation()
    }

    func stopTrip() {
        self.locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        if let lastLocation = self.locations.last {
            let distance = newLocation.distance(from: lastLocation)
            self.totalDistance += distance
            
            let timeInterval = newLocation.timestamp.timeIntervalSince(lastLocation.timestamp)
            let speed = distance / timeInterval
            self.currentSpeed = speed * 3.6
            self.totalSpeed += self.currentSpeed
            self.speedCount += 1
            if self.currentSpeed > self.maxSpeed {
                self.maxSpeed = self.currentSpeed
            }
            
            let acceleration = abs(self.currentSpeed - (lastLocation.speed * 3.6)) / timeInterval
            if acceleration > self.maxAcceleration {
                self.maxAcceleration = acceleration
            }
        }
        
        self.locations.append(newLocation)
        self.locationUpdateDelegate?.didUpdateLocation(locations: locations)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

