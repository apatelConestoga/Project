//
//  RecentCVC.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-16.
//

import UIKit

class RecentCVC: UICollectionViewCell {

    
    @IBOutlet weak var imgTrip: UIImageView!
    @IBOutlet weak var lblTrip: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
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
    }
    
    func configureCell(value: SuggestedTrip) {
        self.lblTrip.text = value.tripName
        self.imgTrip.image = UIImage(named: value.tripImage)
    }

}
