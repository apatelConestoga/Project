//
//  HomeViewController.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-10.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var btnAddTrip: UIBarButtonItem!
    @IBOutlet weak var viewSearch: UIView!
    
    @IBOutlet weak var viewBGImg: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureOutlets()
    }
    
    private func configureOutlets() {
        self.viewSearch.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor)
        self.viewBGImg.backgroundColor = .clear
        self.imgUser.cornerRadius(corner: self.imgUser.frame.width / 2)
        self.viewBGImg.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor)
        
    }
    
}

//MARK:- Action Methods
extension HomeViewController {
    @IBAction func btnAddTripPressed(_ sender: UIBarButtonItem) {
        self.redirectToAddTrip()
    }
    
    @IBAction func btnSearchPressed(_ sender: UIButton) {
        self.redirectToTripList()
    }
}


//MARK:- Navigation
extension HomeViewController {
    func redirectToAddTrip() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "AddTripViewController") as! AddTripViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func redirectToTripList() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TripListViewController") as! TripListViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
