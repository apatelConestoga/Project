//
//  OngoingCVC.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-17.
//

import UIKit

class OngoingCVC: UICollectionViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblTrip: UILabel!
    @IBOutlet weak var imgOngoing: UIImageView!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var viewDash: UIView!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblTotalBudget: UILabel!
    @IBOutlet weak var btnTripDetail: UIButton!
    
    static let identifier = String(describing: OngoingCVC.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    var onClickTripDetailPressed:((Int16)->())?
    var tripId: Int16 = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewDash.drawDottedLine(start: CGPoint(x: self.viewDash.bounds.minX, y: self.viewDash.bounds.minY), end: CGPoint(x: self.viewDash.bounds.maxX, y: self.viewDash.bounds.minY))
        self.btnTripDetail.cornerRadius(corner: 10)
        self.imgOngoing.cornerRadius(corner: 10)
        self.viewBg.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
        
    }

    func configureCell(value: TripDetails) {
        self.lblTrip.text = value.name
        self.lblOrigin.text = value.originLocality
        self.lblDestination.text = value.destinationLocality
        self.lblTotalBudget.text = "$" + (value.totalBudget ?? "")
        self.imgOngoing.image = UIImage.init(data: value.tripImage!)
        self.tripId = value.tripId
    }
    
    
    
    @IBAction func btnTripDetailPressed(_ sender: UIButton) {
        self.onClickTripDetailPressed?(self.tripId)
    }
    
}
