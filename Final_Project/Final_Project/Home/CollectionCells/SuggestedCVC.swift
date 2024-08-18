//
//  SuggestedCVC.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-16.
//

import UIKit

class SuggestedCVC: UICollectionViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgTrip: UIImageView!
    
    @IBOutlet weak var viewBlur: UIView!
    @IBOutlet weak var viewTag: UIView!
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var lblTripDestination: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTotalDays: UILabel!
    
    static let identifier = String(describing: SuggestedCVC.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewContent.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
        self.viewTag.cornerRadius(corner: 10)
        self.imgTrip.cornerRadius(corner: 10)
        self.viewBlur.cornerRadius(corner: 10)
    }

    func configureCell(value: SuggestedTrip) {
        self.lblTripDestination.text = value.tripName
        self.lblDate.text = value.tripDate
        self.lblTotalDays.text = value.totalDays
        self.imgTrip.image = UIImage(named: value.tripImage)
        
        if value.isMostRated {
            self.viewTag.isHidden = false
        } else {
            self.viewTag.isHidden = true
        }
    }
}
