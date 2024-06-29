//
//  LIstCell.swift
//  Midterm
//
//  Created by Adeesh on 2024-06-28.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMonthYear: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgTask: UIImageView!
    @IBOutlet weak var viewPriority: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
