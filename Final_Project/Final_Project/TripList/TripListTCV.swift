//
//  TripListTCV.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-17.
//

import UIKit

class TripListTCV: UITableViewCell {

    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imgTrip: UIImageView!
    @IBOutlet weak var viewBlur: UIView!
    @IBOutlet weak var lblTripName: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblBudget: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    static let identifier = String(describing: TripListTCV.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewBg.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
//        self.viewBg.setRandomBackgroundColor()
        
        self.imgTrip.cornerRadius(corner: 10)
        self.viewBlur.cornerRadius(corner: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
