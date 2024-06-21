//
//  ToDoListCell.swift
//  Lab6_Tableview
//
//  Created by Adeesh on 2024-06-21.
//

import UIKit

class ToDoListCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var lblToDo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    //MARK: - User Functions
    func configureCell(value: String) {
        self.lblToDo.text = value
    }
}
