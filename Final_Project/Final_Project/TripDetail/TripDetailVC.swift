//
//  TripDetailVC.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-17.
//

import UIKit
import CoreLocation
import MapKit

class TripDetailVC: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var imgTrip: UIImageView!
    @IBOutlet weak var viewWeather: UIView!
    
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWeatherType: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    
    @IBOutlet weak var lblTripName: UILabel!
    @IBOutlet weak var lblBudget: UILabel!
    @IBOutlet weak var lblOriginAddress: UILabel!
    @IBOutlet weak var viewDash: UIView!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnDriving: UIButton!
    @IBOutlet weak var btnWalking: UIButton!
    @IBOutlet weak var viewEstimate: UIView!
    @IBOutlet weak var lblEstimate: UILabel!
    @IBOutlet weak var btnManageExpenses: UIButton!
    
    var tripId:Int16 = 0
    let objDBHelper = DBHelper()
    let request = MKDirections.Request()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setCustomBackButton()
        viewDash.drawVerticalDottedLine(atX: self.viewDash.bounds.midX,
                                        startY: self.viewDash.bounds.minY,
                                        endY: self.viewDash.bounds.maxY)
        self.viewWeather.cornerRadius(corner: 20)
        self.btnDriving.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
        self.btnWalking.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
        self.btnManageExpenses.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
        self.mapView.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
        
        self.configureValues()
        self.mapView.delegate = self

    }

    func configureValues() {
        if let objTrip = objDBHelper.getTrip(byID: tripId, searchQuery: nil).first {
            self.imgTrip.image = UIImage.init(data: objTrip.tripImage!)
            self.lblTripName.text = objTrip.name
            self.lblBudget.text = "$" + (objTrip.totalBudget ?? "")
            self.lblOriginAddress.text = objTrip.originLocation
            self.lblDestination.text = objTrip.destinationLocation
            self.lblDate.text = (objTrip.startDate?.convertToString() ?? "") + " to " + (objTrip.endDate?.convertToString() ?? "")
            self.lblDescription.text = objTrip.tripDescripation
            self.callWeatherAPI(latitude: objTrip.destinationLatitude, longitude: objTrip.destinationLongitude)
            self.showRoute(origin: CLLocationCoordinate2D(latitude: objTrip.originLatitude, longitude: objTrip.originLongitude), destination: CLLocationCoordinate2D(latitude: objTrip.destinationLatitude, longitude: objTrip.destinationLongitude))
        }
    }
    
    private func callWeatherAPI(latitude:Double, longitude: Double) {
        self.getAddressFromLatLon(latitude: "\(latitude)", longitude: "\(longitude)") { address in
            WeatherService().fetchWeatherData(latitude: latitude, longitude: longitude, address: address ?? "") { result in
                switch result {
                case .success(let weatherModel):
                    DispatchQueue.main.async {
                        self.dispayingWeatherData(weatherModel)
                    }
                    
                case .failure(let error):
                    print("Error fetching weather data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func dispayingWeatherData(_ weatherModel: WeatherModel) {
        self.lblWeatherType.text = weatherModel.weather.first?.description
        
        self.lblTemp.text = "\(round(weatherModel.main.temp)) °C"
        self.lblHumidity.text = "Humidity: \(weatherModel.main.humidity) %"
        let windSpeedInKmH = weatherModel.wind.speed * 3.6
        let windSpeed = String(format: "%.1f", windSpeedInKmH)
        self.lblWind.text = "Wind: \(windSpeed) km/h"
        
        if let icon = weatherModel.weather.first?.icon,
           let iconURL = URL(string: "http://openweathermap.org/img/w/\(icon).png") {
            WeatherService().setImageFromStringrURL(stringUrl: iconURL) { image in
                self.imgWeather.image = image
            }
        }
    }
    
    private func showRoute(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        LocationManager.shared.locationUpdateDelegate = self
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: origin))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        DispatchQueue.main.async {
            self.request.transportType = .automobile
            self.btnDriving.backgroundColor = UIColor.appColor(.primaryAlpha)
            self.btnWalking.backgroundColor = UIColor.white
            self.setDirection()
        }
        
    }
    
    
    func setDirection() {
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Error calculating directions: \(error.localizedDescription)")
                // Handle the error gracefully
                DispatchQueue.main.async {
                    self.lblEstimate.text = "Unable to calculate route."
                }
                return
            }
            
            guard let response = response, let route = response.routes.first else {
                print("No route found.")
                // Handle the case where no route is found
                DispatchQueue.main.async {
                    self.lblEstimate.text = "No route found."
                }
                return
            }
            
            // Remove existing overlays and annotations
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            // Add the route to the map
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
            // Update estimated time
            let travelTime = route.expectedTravelTime
            self.updateEstimatedTimeLabel(seconds: travelTime)
            
            // Add annotations for origin and destination
            let originAnnotation = MKPointAnnotation()
            originAnnotation.coordinate = (self.request.source?.placemark.coordinate)!
            originAnnotation.title = "Origin"
            self.mapView.addAnnotation(originAnnotation)
            
            let destinationAnnotation = MKPointAnnotation()
            destinationAnnotation.coordinate = (self.request.destination?.placemark.coordinate)!
            destinationAnnotation.title = "Destination"
            self.mapView.addAnnotation(destinationAnnotation)
        }
    }


    private func updateEstimatedTimeLabel(seconds: TimeInterval) {
        let totalMinutes = Int(seconds / 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        var timeString = ""
        if hours > 0 {
            timeString += "\(hours)h "
        }
        timeString += "\(minutes)min"
        
        self.lblEstimate.text = "Estimated Time: \(timeString)"
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.appColor(.accent)
            renderer.lineWidth = 4.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

//MARK: - Button Action
extension TripDetailVC {
    
    @IBAction func btnManageExpensesPressed(_ sender: UIButton) {
        self.redirectToManageExpenses()
    }
    
    @IBAction func btnDrivingPressed(_ sender: UIButton) {
        request.transportType = .automobile
        self.btnDriving.backgroundColor = UIColor.appColor(.primaryAlpha)
        self.btnWalking.backgroundColor = UIColor.white
        self.setDirection()
    }
    
    @IBAction func btnWalkingPressed(_ sender: UIButton) {
        request.transportType = .walking
        self.btnDriving.backgroundColor = UIColor.white
        self.btnWalking.backgroundColor = UIColor.appColor(.primaryAlpha)
        self.setDirection()
    }
}
//MARK: - Navigation
extension TripDetailVC: LocationUpdateDelegate {
    
    func didUpdateLocation(locations: CLLocation) {
        let region = MKCoordinateRegion(center: locations.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
}

//MARK: - Navigation
extension TripDetailVC {
    
    func redirectToManageExpenses() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ManageExpensesVC") as! ManageExpensesVC
        viewController.tripId = self.tripId
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
