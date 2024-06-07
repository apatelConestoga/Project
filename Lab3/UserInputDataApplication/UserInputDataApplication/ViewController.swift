//
//  ViewController.swift
//  UserInputDataApplication
//
//  Created by Adeesh on 2024-05-23.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtUserInputs: UITextView!
    @IBOutlet weak var lblSuccess: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    
    //MARK: - Variables
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureOutlets()
    }
    
    private func configureOutlets() {
        self.txtFirstName.layer.borderWidth = 0.5
        self.txtFirstName.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.txtFirstName.layer.cornerRadius = 10
        self.txtFirstName.delegate = self
        
        self.txtLastName.layer.borderWidth = 0.5
        self.txtLastName.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.txtLastName.layer.cornerRadius = 10
        self.txtLastName.delegate = self
        
        self.txtCountry.layer.borderWidth = 0.5
        self.txtCountry.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.txtCountry.layer.cornerRadius = 10
        self.txtCountry.delegate = self
        
        self.txtAge.layer.borderWidth = 0.5
        self.txtAge.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.txtAge.layer.cornerRadius = 10
        self.addDoneButtonOnAgeTextField()
        
        self.txtUserInputs.layer.borderWidth = 0.5
        self.txtUserInputs.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.txtUserInputs.layer.cornerRadius = 10
        self.txtUserInputs.isHidden = true
        
        self.btnAdd.layer.cornerRadius = 10
        self.btnSubmit.layer.cornerRadius = 10
        self.btnClear.layer.cornerRadius = 10
        
    }
    
    func isValidation() -> (String, Bool) {
        if self.txtFirstName.text == "" && self.txtLastName.text == "" && self.txtCountry.text == "" && self.txtAge.text == "" {
            return ("Complete the missing Info!", false)
        } else if self.txtFirstName.text == "" {
            return ("Please enter first name!", false)
        } else if self.txtLastName.text == "" {
            return ("Please enter last name!", false)
        } else if self.txtCountry.text == "" {
            return ("Please enter country!", false)
        } else if self.txtAge.text == "" {
            return ("Please enter age!", false)
        } else {
            return ("Successfully submitted!", true)
        }
    }
    
    func addDoneButtonOnAgeTextField() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.txtAge.inputAccessoryView = doneToolbar
        
    }
}

//MARK: - Button Actions
extension ViewController {
    @IBAction func btnOptionsClicked(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.txtUserInputs.isHidden = false
            self.lblSuccess.text = ""
            self.txtUserInputs.text = "Full Name: \(self.txtFirstName.text ?? "") \(self.txtLastName.text ?? "") \nCountry: \(self.txtCountry.text ?? "") \nAge: \(self.txtAge.text ?? "")"
        case 2:
            self.lblSuccess.isHidden = false
            if isValidation().1 == true {
                self.lblSuccess.textColor = .green
            } else {
                self.txtUserInputs.text = ""
                self.txtUserInputs.isHidden = true
                self.lblSuccess.textColor = .red
            }
            self.lblSuccess.text = isValidation().0
        default:
            self.txtFirstName.becomeFirstResponder()
            self.txtFirstName.text = ""
            self.txtLastName.text = ""
            self.txtCountry.text = ""
            self.txtAge.text = ""
            self.txtUserInputs.text = ""
            self.txtUserInputs.isHidden = true
            self.lblSuccess.text = ""
            self.lblSuccess.isHidden = true
        }
    }
    
    @objc func doneButtonAction() {
        self.txtAge.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
