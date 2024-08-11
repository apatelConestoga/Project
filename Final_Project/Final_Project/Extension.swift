//
//  Extension+UITextfiled.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-10.
//

import UIKit

enum AssetsColor {
    case primary
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
}

extension UIViewController {
    func setCustomBackButton() {
        let backImage = UIImage(named: "ic_left_arrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
}
