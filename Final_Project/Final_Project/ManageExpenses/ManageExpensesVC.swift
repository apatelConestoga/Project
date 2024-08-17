//
//  ManageExpensesVC.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-17.
//

import UIKit

class ManageExpensesVC: UIViewController {

    
    @IBOutlet weak var txtExpensesName: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    
    @IBOutlet weak var tblExpenses: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnResetPressed(_ sender: UIButton) {
    }
    
    @IBAction func btnSavePressed(_ sender: UIButton) {
        
    }
    
}
