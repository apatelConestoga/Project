//
//  ToDoTBLCell.swift
//  Lab6_Tableview
//
//  Created by Adeesh on 2024-07-07.
//

import UIKit

class ToDoTBLCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    static let identifier = String(describing: ToDoTBLCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(value: String) {
        self.viewBg.layer.cornerRadius = 10
        self.viewBg.backgroundColor = .random()
        self.lblTitle.text = value
    }
    
}
