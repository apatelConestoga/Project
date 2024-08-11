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
    @IBOutlet weak var viewBgTableview: UIView!
    @IBOutlet weak var constrainViewBgTableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureOutlets()
    }
    
    private func configureOutlets() {
        self.setCustomBackButton()
        
        self.viewSearch.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor)
        
//        self.txtSearch.delegate = self
        self.txtSearch.withImage(direction: .Left, image: UIImage(named: "ic_search") ?? UIImage(), colorSeparator: .clear, colorBorder: .clear)
        
        self.viewBgTableview.cornerRadius(corner: 20)
        self.viewBgTableview.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor)
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn) {
            self.constrainViewBgTableViewHeight.constant = UIScreen.main.bounds.height - 180
            self.viewBgTableview.alpha = 1
            self.view.layoutIfNeeded()
            
        }
        
    }
}
