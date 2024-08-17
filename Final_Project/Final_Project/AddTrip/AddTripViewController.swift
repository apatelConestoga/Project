//
//  AddTripViewController.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-11.
//

import UIKit
import MapKit

class AddTripViewController: UIViewController {

    @IBOutlet weak var txtTripName: UITextField!
    @IBOutlet weak var txtStartLocation: UITextField!
    @IBOutlet weak var btnStartLocation: UIButton!
    @IBOutlet weak var txtDestinationLocation: UITextField!
    @IBOutlet weak var btnDestinationLocation: UIButton!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    
    @IBOutlet weak var txtTotalBudget: UITextField!
    
    @IBOutlet weak var imgLocation: UIImageView!
    
    
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var isOriginAddress = false
    var selectedStartDate: Date?
    var selectedEndDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCustomBackButton()
        self.configureOutlets()
    }
    
    private func configureOutlets() {
        self.txtStartDate.addInputViewDatePicker(target: self, selector: #selector(self.btnStartDateTextfieldPressed))
        self.txtEndDate.addInputViewDatePicker(target: self, selector: #selector(self.btnEndDateTextfieldPressed))
        self.btnSave.cornerRadius(corner: 10)
        self.btnReset.cornerRadius(corner: 10)
        self.txtDesc.delegate = self
        self.txtDesc.text = "Let's do some planning for your upcoming trip..."
        self.txtDesc.textColor = UIColor.lightGray
    }
    
    
}

//MARK: - Action Methods
extension AddTripViewController {
    
    @IBAction func btnDirectionPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            print("Start")
            self.isOriginAddress = true
            self.redirectToSelectLocation()
        } else {
            self.isOriginAddress = false
            self.redirectToSelectLocation()
            print("Destination")
        }
    }
    
    @IBAction func btnUploadImgPressed(_ sender: UIButton) {
    }
    
    @IBAction func btnResetPressed(_ sender: UIButton) {
        self.txtTripName.text?.removeAll()
        self.txtStartLocation.text?.removeAll()
        self.txtDestinationLocation.text?.removeAll()
        self.txtStartDate.text?.removeAll()
        self.txtEndDate.text?.removeAll()
        self.txtDesc.text.removeAll()
    }
    
    @IBAction func btnSavePressed(_ sender: UIButton) {
    }
    
    @objc func btnStartDateTextfieldPressed() {
        if let datePicker = self.txtStartDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy"
            self.selectedStartDate = datePicker.date
            self.txtStartDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtStartDate.resignFirstResponder()
    }
    
    @objc func btnEndDateTextfieldPressed() {
        if let datePicker = self.txtEndDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy"
            self.selectedEndDate = datePicker.date
            self.txtEndDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtEndDate.resignFirstResponder()
    }
}

//MARK: - Select Location Protocol
extension AddTripViewController: SelectLocationProtocol {
    func getAddressWithLocation(placeMark: MKPlacemark?, isOriginAddress: Bool) {
        if isOriginAddress == true {
            self.txtStartLocation.text = placeMark?.title
        } else {
            self.txtDestinationLocation.text = placeMark?.title
        }
    }
}

//MARK: - UIText View Delegate
extension AddTripViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.appColor(.textBlack)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Let's do some planning for your upcoming trip..."
            textView.textColor = UIColor.lightGray
        }
    }
}

//MARK: - Navigation
extension AddTripViewController {
    func redirectToSelectLocation() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SelectLocationViewController") as! SelectLocationViewController
        viewController.isOriginAddress = isOriginAddress
        viewController.selectLocationProtocol = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
