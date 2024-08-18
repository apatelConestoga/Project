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
    var originLocality: String?
    var destinationLocality: String?
    var originLocation: CLLocationCoordinate2D?
    var destinationLocation: CLLocationCoordinate2D?
    
    var imagePicker =  UIImagePickerController()
    let objDBHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCustomBackButton()
        self.configureOutlets()
    }
    
    private func configureOutlets() {
        self.txtStartDate.addInputViewDatePicker(target: self, selector: #selector(self.btnStartDateTextfieldPressed))
        self.txtEndDate.addInputViewDatePicker(target: self, selector: #selector(self.btnEndDateTextfieldPressed))
        self.btnSave.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
        self.btnReset.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
        self.txtDesc.delegate = self
        self.txtDesc.text = "Let's do some planning for your upcoming trip..."
        self.txtDesc.textColor = UIColor.lightGray
        self.imagePicker.delegate = self
    }
    
    func openGallary() {
        self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.imagePicker.allowsEditing = false
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func saveTripDetails() {
        if self.txtTripName.text != "" && self.txtStartLocation.text != "" && self.txtDestinationLocation.text != "" && self.txtStartDate.text != "" && self.txtEndDate.text != "" && self.txtTotalBudget.text != "" && self.imgLocation.image != UIImage(named: "picture") && self.txtDesc.text != "Let's do some planning for your upcoming trip..." {
            self.objDBHelper.addNewTrip(tripName: self.txtTripName.text ?? "", tripOriginFullAddress: self.txtStartLocation.text ?? "", tripOriginLocality: self.originLocality ?? "", tripOriginLocation: self.originLocation!, tripDestinationFullAddress: self.txtDestinationLocation.text ?? "", tripDestinationLocality: self.destinationLocality ?? "", tripDestinationLocation: self.destinationLocation!, tripStartDate: self.selectedStartDate!, tripEndDate: self.selectedEndDate!, totalBudget: self.txtTotalBudget.text ?? "", tripImage: self.imgLocation.image!, tripDescription: self.txtDesc.text ?? "") { (success) in
                
                if success {
                    self.showAlert(title: "Success", message: "Data Saved!", buttonTitle: "Ok") {
                        self.resetValues()
                        NotificationCenter.default.post(name: Notification.Name("AddNewTrip"), object: nil)
                        self.dismiss(animated: true)
                    }
                } else {
                    print("Could not save.")
                }
            }
        } else {
            self.showAlert(title: "All Fields are required!", message: "Please fill all details", buttonTitle: "Ok") {
                self.dismiss(animated: true)
            }
        }
    }
    
    func resetValues() {
        self.txtTripName.text?.removeAll()
        self.txtStartLocation.text?.removeAll()
        self.txtDestinationLocation.text?.removeAll()
        self.txtStartDate.text?.removeAll()
        self.txtEndDate.text?.removeAll()
        self.txtDesc.text.removeAll()
        self.imgLocation.image = UIImage(named: "picture")
        self.imgLocation.contentMode = .scaleAspectFit
        self.txtTotalBudget.text?.removeAll()
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
        self.openGallary()
    }
    
    @IBAction func btnResetPressed(_ sender: UIButton) {
        self.resetValues()
    }
    
    @IBAction func btnSavePressed(_ sender: UIButton) {
        self.saveTripDetails()
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

//MARK: - ImagePicker Delegate
extension AddTripViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imgLocation.image = image
        self.imgLocation.contentMode = .scaleAspectFill
        self.imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if imgLocation.image == UIImage(named: "picture") {
            self.imgLocation.contentMode = .scaleAspectFit
        } else {
            self.imgLocation.contentMode = .scaleAspectFill
        }
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Select Location Protocol
extension AddTripViewController: SelectLocationProtocol {
    func getAddressWithLocation(placeMark: MKPlacemark?, isOriginAddress: Bool) {
        if isOriginAddress == true {
            self.originLocation = placeMark?.coordinate
            self.originLocality = placeMark?.locality
            self.txtStartLocation.text = placeMark?.title
        } else {
            self.destinationLocation = placeMark?.coordinate
            self.destinationLocality = placeMark?.locality
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
