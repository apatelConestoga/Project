//
//  TextField+Extension.swift
//  Lab4Autolayout
//
//  Created by Adeesh on 2024-05-31.
//

import UIKit

extension UITextField {
    func setBorderCornerRadius() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat = 10){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

extension UIButton {
    func setBorderCornerRadius() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
    }
}

extension UIViewController {
    func showAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
