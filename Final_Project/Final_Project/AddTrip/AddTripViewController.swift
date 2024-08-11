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
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var isOriginAddress = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCustomBackButton()
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
    
    @IBAction func btnResetPressed(_ sender: UIButton) {
    }
    
    @IBAction func btnSavePressed(_ sender: UIButton) {
    }
}

extension AddTripViewController: SelectLocationProtocol {
    func getAddressWithLocation(placeMark: MKPlacemark?, isOriginAddress: Bool) {
        if isOriginAddress == true {
            
            self.txtStartLocation.text = placeMark?.title
        } else {
            self.txtDestinationLocation.text = placeMark?.title
        }
    }
}

//MARK:- Navigation
extension AddTripViewController {
    func redirectToSelectLocation() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SelectLocationViewController") as! SelectLocationViewController
        viewController.isOriginAddress = isOriginAddress
        viewController.selectLocationProtocol = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
