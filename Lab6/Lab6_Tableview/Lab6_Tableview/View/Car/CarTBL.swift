//
//  CarTBL.swift
//  Lab6_Tableview
//
//  Created by Adeesh on 2024-07-07.
//

import UIKit

class CarTBL: UITableViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var lblCarMake: UILabel!
    @IBOutlet weak var lblCarModel: UILabel!
    
    static let identifier = String(describing: CarTBL.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgCar.layer.cornerRadius = 5
        self.viewBG.backgroundColor = .random()
        
        self.viewBG.addDropShadow(shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(value: Car) {
        self.imgCar.image = value.image
        self.lblCarMake.text = value.make
        self.lblCarModel.text = value.model
    }
    
}
