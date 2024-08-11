//
//  Extension+UITextfiled.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-10.
//

import UIKit

enum AssetsColor {
    case primary
    case primaryAlpha
    case secondary
    case accent
    case background
    case textBlack
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
}
