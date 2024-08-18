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
    
    
    var tripId: Int16 = 0
    let objDBHelper = DBHelper()
    var arrExpenses = [TripCalculation]() {
        didSet {
            self.tblExpenses.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureOutlets()
        if let objTrip = objDBHelper.getTrip(byID: self.tripId, searchQuery: nil).first {
            self.arrExpenses = self.objDBHelper.getExpenses(for: objTrip)
        }
    }
    
    private func configureOutlets() {
        self.btnSave.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
        self.btnReset.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 3)
        
        self.configureTableView()
    }
    
    private func configureTableView() {
        self.tblExpenses.delegate = self
        self.tblExpenses.dataSource = self
        
        self.tblExpenses.register(ManageExpensesTVC.nib, forCellReuseIdentifier: ManageExpensesTVC.identifier)
    }
    
    func resetValues() {
        self.txtAmount.text?.removeAll()
        self.txtExpensesName.text?.removeAll()
    }
    
    func saveExpenses() {
        if let objTrip = objDBHelper.getTrip(byID: self.tripId, searchQuery: nil).first {
            if self.txtAmount.text != "" && self.txtExpensesName.text != "" {
                objDBHelper.addNewExpenses(tripDetail: objTrip, amount: Double(self.txtAmount.text ?? "0.00") ?? 0.00, expenseTitle: (self.txtExpensesName.text ?? "")) { (success) in
                    
                    if success {
                        self.arrExpenses = self.objDBHelper.getExpenses(for: objTrip)
                        self.resetValues()
                        self.dismiss(animated: true)
                    } else {
                        print("Could not save.")
                    }
                }
            } else {
                self.showAlert(title: "All Fields are required!", message: "Please fill all details", buttonTitle: "Ok") {
                    self.dismiss(animated: true)
                }
            }
        }
    }
}

//MARK: - Button Action
extension ManageExpensesVC {
    
    @IBAction func btnResetPressed(_ sender: UIButton) {
        self.resetValues()
    }
    
    @IBAction func btnSavePressed(_ sender: UIButton) {
        self.saveExpenses()
    }
}

//MARK: - Button Action
extension ManageExpensesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ManageExpensesTVC.identifier, for: indexPath) as? ManageExpensesTVC else { return UITableViewCell() }
        cell.configureCell(value: self.arrExpenses[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let expense = self.arrExpenses[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.objDBHelper.deleteExpense(expense: expense) { success in
                if success {
                    // Remove the deleted expense from the data source
                    self?.arrExpenses.remove(at: indexPath.row)
                    
                    // Update the table view
                
                } else {
                    print("Failed to delete expense.")
                }
                completionHandler(true)
            }
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
