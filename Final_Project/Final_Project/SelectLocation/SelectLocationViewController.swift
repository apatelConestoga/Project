//
//  SelectLocationViewController.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-11.
//

import UIKit
import MapKit

protocol SelectLocationProtocol {
    func getAddressWithLocation(placeMark: MKPlacemark?, isOriginAddress: Bool)
}

class SelectLocationViewController: UIViewController {

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var constrainViewBottomHeight: NSLayoutConstraint!
    @IBOutlet weak var tblAddress: UITableView!
    @IBOutlet weak var btnSetAddress: UIButton!
    
    var isOriginAddress = true
    var selectLocationProtocol: SelectLocationProtocol? = nil
    var searchCompleter = MKLocalSearchCompleter()
    var arrSearchResults = [MKLocalSearchCompletion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCustomBackButton()
        self.configureOutlets()
        self.configureLocationManager()
        self.configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientView.setGradientBackground()
    }
    
    private func configureOutlets() {
        self.searchCompleter.delegate = self
        self.viewBottom.cornerRadius(corner: 20)
        self.txtSearch.delegate = self
        self.viewSearch.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor)
        self.txtSearch.withImage(direction: .Left, image: UIImage(named: "ic_search") ?? UIImage(), colorSeparator: .clear, colorBorder: .clear)
        self.btnSetAddress.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOpacity: 0.5, shadowOffset: CGSize(width: 5, height: 5), shadowRadius: 10)
    }
    
    private func configureLocationManager() {
        LocationManager.shared.locationUpdateDelegate = self
    }
    
    private func configureTableView() {
        self.tblAddress.delegate = self
        self.tblAddress.dataSource = self
        self.tblAddress.register(UINib(nibName: LocationSearchTVC.identifer, bundle: nil), forCellReuseIdentifier: LocationSearchTVC.identifer)
    }

    func addPins(for mapItems: [MKMapItem]) {
        mapView.removeAnnotations(mapView.annotations)
        
        for item in mapItems {
            let annotation = MKPointAnnotation()
            annotation.coordinate = item.placemark.coordinate
            annotation.title = item.name
            
            if let city = item.placemark.locality, let state = item.placemark.administrativeArea {
                annotation.subtitle = "\(city), \(state)"
            }
            
            mapView.addAnnotation(annotation)
        }
        if let firstCoordinate = mapItems.first?.placemark.coordinate {
            self.selectLocationProtocol?.getAddressWithLocation(placeMark: mapItems.first?.placemark, isOriginAddress: self.isOriginAddress)
            let region = MKCoordinateRegion(center: firstCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    

    func hideTableView() {
        // Hide the view if less than 2 characters
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) {
            self.constrainViewBottomHeight.constant = 0
            self.viewBottom.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func showTableView() {
        // Show the view with animation
        if self.viewBottom.alpha != 1 {
            UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseIn) {
                self.constrainViewBottomHeight.constant = UIScreen.main.bounds.height - 200
                self.viewBottom.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func btnSetAddressPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - UITextField Delegate
extension SelectLocationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else {
            return true
        }
        
        // Calculate the new length of the text
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        // Check if the length is 2 or more characters
        if newText.count >= 2 {
            self.showTableView()
            searchCompleter.queryFragment = newText
        } else {
            self.hideTableView()
            self.arrSearchResults = []
            self.tblAddress.reloadData()
        }
        
        return true
    }

}

extension SelectLocationViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        arrSearchResults = completer.results
        self.tblAddress.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
        self.hideTableView()
        self.arrSearchResults = []
        self.tblAddress.reloadData()
    }
}


//MARK: - Location Manager Delegate
extension SelectLocationViewController: LocationUpdateDelegate {

    func didUpdateLocation(locations: CLLocation) {
        let canadaRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56.1304, longitude: -106.3468),
            span: MKCoordinateSpan(latitudeDelta: 50.0, longitudeDelta: 50.0)
        )
        
        mapView.setRegion(canadaRegion, animated: true)
    }
}

//MARK: - UITableView Delegate and DataSource
extension SelectLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationSearchTVC.identifer, for: indexPath) as? LocationSearchTVC else { return UITableViewCell() }
        cell.configureCell(value: arrSearchResults[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let completion = arrSearchResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let error = error {
                print("Error during local search: \(error.localizedDescription)")
                return
            }
            
            guard let mapItems = response?.mapItems else {
                print("No map items found")
                return
            }
            
            self.addPins(for: mapItems)
            self.txtSearch.text?.removeAll()
            self.hideTableView()
        }
    }
}

