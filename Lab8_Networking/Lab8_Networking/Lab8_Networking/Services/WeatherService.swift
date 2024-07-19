//
//  WeatherService.swift
//  Lab8_Networking
//
//  Created by Adeesh on 2024-07-18.
//

import Foundation
import UIKit

class WeatherService {
    let apiKey = "a4ddf3c091e88cb8f30adca79bb6ee92"
//    3c86cdb94245fa2ca3d0c97d28abc112
    
//    let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
    
    func fetchWeatherData(latitude: Double, longitude: Double, address: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(address),CA&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(weatherData))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }
    
    func setImageFromStringrURL(stringUrl: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: stringUrl) { (data, response, error) in
          guard let imageData = data else { return }
          DispatchQueue.main.async {
              completion(UIImage(data: imageData))
          }
        }.resume()
    }
}
