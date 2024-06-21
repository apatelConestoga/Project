//
//  ViewController.swift
//  Lab6_Tableview
//
//  Created by Adeesh on 2024-06-21.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tblToDo: UITableView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    //MARK: - Variable
    var arrToDo = [ToDoItem]() {
        didSet {
            self.storingItemsInPreferences()
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableConfiguration()
    }
    
    
    //MARK: - Private Functions
    private func tableConfiguration() {
        self.tblToDo.delegate = self
        self.tblToDo.dataSource = self
        self.retriveItemsFromPreference()
    }
    
    //MARK: - Storing in Preference
    func storingItemsInPreferences() {
        if let encodedData = try? JSONEncoder().encode(arrToDo) {
            UserDefaults.standard.set(encodedData, forKey: "toDoItems")
        }
    }
    
    //MARK: - Retrive from Preference
    func retriveItemsFromPreference() {
        if let savedData = UserDefaults.standard.data(forKey: "toDoItems"),
           let decodedItems = try? JSONDecoder().decode([ToDoItem].self, from: savedData) {
            self.arrToDo = decodedItems
            self.hideTableView(isHidden: false)
        } else {
            self.hideTableView(isHidden: true)
        }
    }
    
    func hideTableView(isHidden: Bool) {
        if isHidden {
            self.tblToDo.isHidden = true
            self.lblNoDataFound.isHidden = false
        } else {
            self.tblToDo.isHidden = false
            self.lblNoDataFound.isHidden = true
        }
    }
}

//MARK: - Button Action
extension ViewController {
    @IBAction func btnPlusClick(_ sender: UIBarButtonItem) {
        self.showInputDialog(title: "Add Item", subtitle: "", actionTitle: "Add", cancelTitle: "Cancel", inputPlaceholder: "Write an Item", inputKeyboardType: .asciiCapableNumberPad) { action in
            self.dismiss(animated: true)
        } actionHandler: { text in
            self.hideTableView(isHidden: false)
            self.arrToDo.append(ToDoItem(title: text ?? ""))
            self.tblToDo.reloadData()
        }
    }
}

//MARK: - Table View Delegate and DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrToDo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ToDoListCell else { return UITableViewCell()}
        cell.configureCell(value: self.arrToDo[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.arrToDo.remove(at: indexPath.row)
            self.tblToDo.deleteRows(at: [indexPath], with: .fade)
            if self.arrToDo.isEmpty {
                self.hideTableView(isHidden: true)
            }
        }
    }
}

