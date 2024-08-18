//
//  ManageExpensesTVC.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-17.
//

import UIKit

class ManageExpensesTVC: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblExpenses: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    static let identifier = String(describing: ManageExpensesTVC.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBg.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(value: TripCalculation) {
        self.lblExpenses.text = value.expenseTitle
        self.lblAmount.text = "$" + "\(value.amount)"
    }
    
}
