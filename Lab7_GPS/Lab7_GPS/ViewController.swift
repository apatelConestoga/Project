//
//  ViewController.swift
//  Lab7_GPS
//
//  Created by Adeesh on 2024-07-11.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblMaxSpeed: UILabel!
    @IBOutlet weak var lblAverageSpeed: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblAcceleration: UILabel!
    @IBOutlet weak var viewTopBar: UIView!
    @IBOutlet weak var viewBottomBar: UIView!
    @IBOutlet weak var lblDistanceBeforeLimit: UILabel!
    
    //MARK: - Variables
    let locationManager = LocationManager.shared

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnStart.layer.cornerRadius = 10
        self.btnStop.layer.cornerRadius = 10
        self.viewBottomBar.backgroundColor = .gray
        self.viewTopBar.backgroundColor = .clear
        self.mapView.showsUserLocation = true
        self.locationManager.locationUpdateDelegate = self
    }

    
    //MARK: - User Functions
    func updateUI() {
        
        let manager = LocationManager.shared
        self.lblSpeed.text = String(format: "Speed: %.2f km/h", manager.currentSpeed)
        self.lblMaxSpeed.text = String(format: "Max Speed: %.2f km/h", manager.maxSpeed)
        self.lblAverageSpeed.text = String(format: "Avg Speed: %.2f km/h", manager.averageSpeed)
        self.lblDistance.text = String(format: "Distance: %.2f km", manager.totalDistance / 1000) // Convert meters to kilometers
        self.lblAcceleration.text = String(format: "Max Acceleration: %.2f m/s²", manager.maxAcceleration)
        
        if manager.currentSpeed > 115 {
            self.viewTopBar.backgroundColor = .red
        } else {
            let distanceBeforeLimit = (manager.customSpeedLimit - manager.currentSpeed) * 1000 / 3600
            self.lblDistanceBeforeLimit.text = String(format: "Distance before limit: %.2f km", distanceBeforeLimit)
            self.viewTopBar.backgroundColor = .clear
        }
        
    }
}

extension ViewController {
    @IBAction func btnStartTripClicked(_ sender: UIButton) {
        self.locationManager.startTrip()
        self.viewBottomBar.backgroundColor = .green
    }

    @IBAction func btnStopTripClicked(_ sender: UIButton) {
        self.locationManager.stopTrip()
        self.viewBottomBar.backgroundColor = .gray
    }
}

extension ViewController: LocationUpdateDelegate {
    
    func didUpdateLocation(locations: [CLLocation]) {
        self.updateUI()
        
        if let location = locations.last {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            self.mapView.setRegion(region, animated: true)
        }
    }
}

