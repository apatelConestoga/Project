//
//  TripListViewController.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-11.
//

import UIKit

class TripListViewController: UIViewController {

    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblTripList: UITableView!
    
    var arrAllTrip = [TripDetails]() {
        didSet {
            self.tblTripList.reloadData()
        }
    }
    let objDBHelper = DBHelper()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        self.configureOutlets()
        self.arrAllTrip = self.objDBHelper.getTrip(searchQuery: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("AddNewTrip"), object: nil)
    }
    
    private func configureOutlets() {
        self.setCustomBackButton()
        
        self.viewSearch.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor)
        
        self.txtSearch.delegate = self
        self.txtSearch.withImage(direction: .Left, image: UIImage(named: "ic_search") ?? UIImage(), colorSeparator: .clear, colorBorder: .clear)
    }
    
    private func configureTableView() {
        self.tblTripList.delegate = self
        self.tblTripList.dataSource = self
        
        self.tblTripList.register(TripListTCV.nib, forCellReuseIdentifier: TripListTCV.identifier)
        self.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.tblTripList.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        self.arrAllTrip = self.objDBHelper.getTrip(searchQuery: nil)
        refreshControl.endRefreshing()
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.arrAllTrip = self.objDBHelper.getTrip(searchQuery: nil)
    }
}
//MARK: - UITextField Delegate
extension TripListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Combine the current text with the new characters
        let currentText = textField.text ?? ""
        guard let textRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        
        // Update the search query
        let searchQuery = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Perform the search only if the query has 2 or more characters
        if searchQuery.count >= 2 {
            let filteredTrips = self.objDBHelper.getTrip(searchQuery: searchQuery)
            self.arrAllTrip = filteredTrips
        } else {
            // Clear the results if the query is less than 2 characters
            self.arrAllTrip = self.objDBHelper.getTrip(searchQuery: nil)
        }
        
        return true
    }
}


//MARK: - UITableView Delegate and DataSource
extension TripListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAllTrip.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TripListTCV.identifier, for: indexPath) as? TripListTCV else { return UITableViewCell() }
        cell.configureCell(value: self.arrAllTrip[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objTrip = self.arrAllTrip[indexPath.row].tripId
        self.redirectToTripDetail(tripId: objTrip)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trip = self.arrAllTrip[indexPath.row] // Make sure this is your array of trips
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.objDBHelper.deleteTrip(trip: trip) { success in
                if success {
                    // Remove the deleted trip from the data source
                    self?.arrAllTrip.remove(at: indexPath.row)
                    
                    // Update the table view
                } else {
                    print("Failed to delete trip.")
                }
                completionHandler(true)
            }
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

//MARK: - Navigation
extension TripListViewController {
    
    func redirectToTripDetail(tripId: Int16) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TripDetailVC") as! TripDetailVC
        viewController.tripId = tripId
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
