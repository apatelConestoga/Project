//
//  SettingCell.swift
//  Midterm
//
//  Created by Adeesh on 2024-07-01.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var lblSetting: UILabel!
    @IBOutlet weak var imgSelect: UIImageView!
    
    static let identiifier = String(describing: SettingCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfiguration(obj: SettingValue) {
        if obj.isSelected == true {
            self.imgSelect.image = UIImage(named: "ic_radio_selected")
        } else {
            self.imgSelect.image = UIImage(named: "ic_radio_unselected")
        }
        self.lblSetting.text = obj.value
    }
}
