//
//  UpcomingTripCVC.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-16.
//

import UIKit

class UpcomingTripCVC: UICollectionViewCell {
    
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgTrip: UIImageView!
    @IBOutlet weak var lblTripName: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var viewBlur: UIView!
    static let identifier = String(describing: UpcomingTripCVC.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewContent.cornerRadius(corner: 10)
        self.imgTrip.cornerRadius(corner: 10)
        self.viewBlur.cornerRadius(corner: 10)
        
    }

    
    func configureCell(value: SuggestedTrip) {
        self.lblTripName.text = value.tripName
        self.lblDate.text = value.tripDate
        self.imgTrip.image = UIImage(named: value.tripImage)
    }
}
