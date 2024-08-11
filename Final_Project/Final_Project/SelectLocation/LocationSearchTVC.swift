//
//  LocationSearchTVC.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-11.
//

import UIKit
import MapKit

class LocationSearchTVC: UITableViewCell {

    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    static let identifer = String(describing: LocationSearchTVC.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBg.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(value: MKLocalSearchCompletion) {
        self.lblTitle.text = value.title
        self.lblDescription.text = value.subtitle
    }
    
    
}
