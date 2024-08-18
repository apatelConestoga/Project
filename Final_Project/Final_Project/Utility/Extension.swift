//
//  Extension+UITextfiled.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-10.
//

import UIKit
import CoreLocation

enum AssetsColor {
    case primary
    case primaryAlpha
    case secondary
    case accent
    case background
    case textBlack
    case textBlackAlpha
}

extension UIColor {
    
    static func appColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .primary:
            return UIColor(named: "Primary")
        case .primaryAlpha:
            return UIColor(named: "Primary")?.withAlphaComponent(0.5)
        case .secondary:
            return UIColor(named: "Secondary")
        case .accent:
            return UIColor(named: "Accent")
        case .background:
            return UIColor(named: "Background")
        case .textBlack:
            return UIColor(named: "Text")
        case .textBlackAlpha:
            return UIColor(named: "Text")?.withAlphaComponent(0.5)
        }
    }
}



extension UITextField {
    
    enum Direction {
        case Left
        case Right
    }
    
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 5
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)
        
        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(0.5)
        self.layer.cornerRadius = 5
    }
    
}

extension UIView {
    func addDropShadow(shadowColor: CGColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor, shadowOpacity: Float = 0.3,
                       shadowOffset: CGSize = CGSize(width: 5, height: 5),
                       shadowRadius: CGFloat = 15) {
        
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
    }
    
    func cornerRadius(corner: CGFloat) {
        self.layer.cornerRadius = corner
    }
    
    func setGradientBackground() {
        guard let colorTop = UIColor.appColor(.primary)?.cgColor else {
            print("Failed to load color for gradient.")
            return
        }
        
        guard let colorMiddle = UIColor.appColor(.primaryAlpha)?.cgColor else {
            print("Failed to load color for gradient.")
            return
        }
        
        let colorBottom = UIColor.clear.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorMiddle, colorBottom]
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.frame = self.bounds
        self.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackgroundFromBottom() {
        guard let colorTop = UIColor.appColor(.textBlack)?.cgColor else {
            print("Failed to load color for gradient.")
            return
        }
        
        guard let colorMiddle = UIColor.appColor(.textBlackAlpha)?.cgColor else {
            print("Failed to load color for gradient.")
            return
        }
        
        let colorBottom = UIColor.clear.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom, colorMiddle, colorTop]
        gradientLayer.locations = [0.0, 0.5, 1.0] // Start at bottom, middle, and top
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0) // Bottom center
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)   // Top center
        gradientLayer.frame = self.bounds
        
        // Remove existing gradient layers to prevent overlap
        self.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        
        // Insert the new gradient layer
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.appColor(.primary)?.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3]

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawVerticalDottedLine(atX xPosition: CGFloat, startY: CGFloat, endY: CGFloat) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.appColor(.primary)?.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // Length and spacing of the dashes
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: xPosition, y: startY), CGPoint(x: xPosition, y: endY)])
        shapeLayer.path = path
        
        self.layer.addSublayer(shapeLayer)
    }
}

extension UIViewController {
    func setCustomBackButton() {
        let backImage = UIImage(named: "ic_left_arrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func showAlert(title: String, message: String, buttonTitle: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion()
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openLocationSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        }
    }
    
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

extension UITextField {
    
    func addInputViewDatePicker(target: Any, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
//        datePicker.minimumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        
        self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
}

extension Date {
    
    func convertToString(format: String = "dd-MMM-yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
