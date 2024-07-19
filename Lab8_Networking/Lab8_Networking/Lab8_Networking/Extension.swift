//
//  Extension.swift
//  Lab8_Networking
//
//  Created by Adeesh on 2024-07-18.
//

import UIKit
import CoreLocation

extension UIViewController {
    
    func getAddressFromLatLon(latitude: String, longitude: String, completion: @escaping (String?) -> Void) {
        var addressString: String = ""
        guard let lat = Double(latitude), let lon = Double(longitude) else {
            completion(nil)
            return
        }
        
        let ceo: CLGeocoder = CLGeocoder()
        let location: CLLocation = CLLocation(latitude: lat, longitude: lon)
        
        ceo.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if let error = error {
                print("Reverse geocode failed: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemarks = placemarks, placemarks.count > 0 else {
                completion(nil)
                return
            }
            
            let placemark = placemarks[0]
            
            if let locality = placemark.locality {
                addressString += locality + ", "
            }
            if let country = placemark.country {
                addressString += country + ", "
            }
            
            completion(addressString.trimmingCharacters(in: .whitespacesAndNewlines))
        })
    }
    
}

