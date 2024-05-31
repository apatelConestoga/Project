//
//  ViewController.swift
//  Lab4Autolayout
//
//  Created by Adeesh on 2024-05-30.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtOutput: UITextView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    
    //MARK: - Variables
    let ageDatePicker = UIDatePicker()
    let formatter = DateFormatter()
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formatter.dateFormat = "dd/MM/yyyy"
        self.configureTextField()
        self.configureButton()
        self.showDatePicker()
    }
    
}

//MARK: - Private Methods
extension ViewController {
    
    private func configureTextField() {
        self.txtFirstName.delegate = self
        self.txtFirstName.setBorderCornerRadius()
        self.txtFirstName.setLeftPaddingPoints()
        
        self.txtSurname.delegate = self
        self.txtSurname.setBorderCornerRadius()
        self.txtSurname.setLeftPaddingPoints()
        
        self.txtAddress.delegate = self
        self.txtAddress.setBorderCornerRadius()
        self.txtAddress.setLeftPaddingPoints()
        
        self.txtCity.delegate = self
        self.txtCity.setBorderCornerRadius()
        self.txtCity.setLeftPaddingPoints()
        
        self.txtDOB.delegate = self
        self.txtDOB.setBorderCornerRadius()
        self.txtDOB.setLeftPaddingPoints()
    }
    
    private func configureButton() {
        self.btnReset.setBorderCornerRadius()
        self.btnDecline.setBorderCornerRadius()
        self.btnAccept.setBorderCornerRadius()
    }
    
    private func showDatePicker() {
        //Formate Date
        self.ageDatePicker.datePickerMode = .date
        self.ageDatePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        self.txtDOB.inputAccessoryView = toolbar
        self.txtDOB.inputView = self.ageDatePicker
    }
    
    private func isValidation() -> (String, Bool) {
        if self.txtFirstName.text == "" && self.txtSurname.text == "" && self.txtAddress.text == "" && self.txtCity.text == "" && self.txtDOB.text == "" {
            return ("Complete the all missing Info!", false)
        } else if self.txtFirstName.text == "" {
            return ("Please enter first name!", false)
        } else if self.txtSurname.text == "" {
            return ("Please enter surname!", false)
        } else if self.txtAddress.text == "" {
            return ("Please enter address!", false)
        } else if self.txtCity.text == "" {
            return ("Please enter city!", false)
        } else if self.txtDOB.text == "" {
            return ("Please enter date of birth!", false)
        } else {
            return ("Successfully submitted!", true)
        }
    }
    
    private func clearAllFields() {
        self.txtFirstName.text = ""
        self.txtSurname.text = ""
        self.txtAddress.text = ""
        self.txtCity.text = ""
        self.txtDOB.text = ""
        self.txtOutput.text = ""
    }
}

//MARK: - Button Action
extension ViewController {
    @IBAction func clickOptionButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            //reset
            self.clearAllFields()
            break
        case 2:
            //decline
            self.clearAllFields()
            self.txtOutput.text = "User clicked on decline button."
            break
        default:
            
            let date = self.formatter.date(from: self.txtDOB.text ?? "")
            let age = Calendar.current.dateComponents([.year], from: date ?? Date(), to: Date()).year ?? 0
            
            if !isValidation().1 {
                self.txtOutput.text = isValidation().0
            } else if age < 18 {
                self.showAlert(title: "Oops...", message: "Your age is should be 18 year") {
                    self.txtDOB.text = ""
                    self.dismiss(animated: true)
                }
            } else if isValidation().1 {
                self.txtOutput.text = "I, \(self.txtFirstName.text ?? "") \(self.txtSurname.text ?? ""), currently living at \(self.txtAddress.text ?? "") in the city of \(self.txtCity.text ?? "") do hereby accept the terms and conditions assignment. \n\n I am \(age) and therefore am able to accept the conditions of this assignment."
                self.showAlert(title: "Hooore....", message: "Thank you!, You have successfully enter data") {
                    self.dismiss(animated: true)
                }
            } else {
                self.txtOutput.text = isValidation().0
            }
            break
        }
    }
    
    @objc func doneDatePicker() {
        self.txtDOB.text = formatter.string(from: self.ageDatePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
}

//MARK: - Button Action
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.txtOutput.text != "" {
            self.txtOutput.text = ""
        }
    }
}

