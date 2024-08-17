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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        self.configureOutlets()
    }
    
    private func configureOutlets() {
        self.setCustomBackButton()
        
        self.viewSearch.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor)
        
//        self.txtSearch.delegate = self
        self.txtSearch.withImage(direction: .Left, image: UIImage(named: "ic_search") ?? UIImage(), colorSeparator: .clear, colorBorder: .clear)
        
        
    }
    
    private func configureTableView() {
        self.tblTripList.delegate = self
        self.tblTripList.dataSource = self
        
        self.tblTripList.register(TripListTCV.nib, forCellReuseIdentifier: TripListTCV.identifier)
    }
}

//MARK: - UITableView Delegate and DataSource
extension TripListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TripListTCV.identifier, for: indexPath) as? TripListTCV else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.redirectToTripDetail()
    }
}

//MARK: - Navigation
extension TripListViewController {
    
    func redirectToTripDetail() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TripDetailVC") as! TripDetailVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
