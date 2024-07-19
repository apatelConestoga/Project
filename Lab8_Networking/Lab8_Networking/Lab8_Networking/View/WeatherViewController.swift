//
//  WeatherViewController.swift
//  Lab8_Networking
//
//  Created by Adeesh on 2024-07-18.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgTemp: UIImageView!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var imgHumidity: UIImageView!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var imgSpeed: UIImageView!
    @IBOutlet weak var lblSpeed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLocationManage()
    }
    
    private func configureLocationManage() {
        LocationManager.shared.locationUpdateDelegate = self
    }


    private func fetchWeatherData(location: CLLocation) {
        
        self.getAddressFromLatLon(latitude: "\(location.coordinate.latitude)", longitude: "\(location.coordinate.longitude)") { address in
            WeatherService().fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, address: address ?? "") { result in
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
        self.lblLocation.text = weatherModel.name
        self.lblDescription.text = weatherModel.weather.first?.description
        
        self.lblTemp.text = "\(round(weatherModel.main.temp)) °C"
        self.lblHumidity.text = "Humidity: \(weatherModel.main.humidity) %"
        let windSpeedInKmH = weatherModel.wind.speed * 3.6
        let windSpeed = String(format: "%.1f", windSpeedInKmH)
        self.lblSpeed.text = "Wind: \(windSpeed) km/h"
        
        if let icon = weatherModel.weather.first?.icon,
           let iconURL = URL(string: "http://openweathermap.org/img/w/\(icon).png") {
            WeatherService().setImageFromStringrURL(stringUrl: iconURL) { image in
                self.imgTemp.image = image
            }
        }
    }
}

extension WeatherViewController: LocationUpdateDelegate {
    func didUpdateLocation(location: CLLocation) {
        fetchWeatherData(location: location)
    }
}
