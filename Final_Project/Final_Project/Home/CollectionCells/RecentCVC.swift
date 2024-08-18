//
//  RecentCVC.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-16.
//

import UIKit

class RecentCVC: UICollectionViewCell {

    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgTrip: UIImageView!
    @IBOutlet weak var lblTrip: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblTravelDate: UILabel!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewBlur: UIView!
    
    static let identifier = String(describing: RecentCVC.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgTrip.cornerRadius(corner: 10)
        self.viewBottom.cornerRadius(corner: 10)
        self.viewBlur.cornerRadius(corner: 10)
        self.viewBG.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
    }
    
    func configureCell(value: TripDetails) {
        self.lblTrip.text = value.name
        self.lblDestination.text = value.destinationLocality
        self.lblTravelDate.text = value.endDate?.convertToString()
        self.imgTrip.image = UIImage.init(data: value.tripImage!)
    }

}
