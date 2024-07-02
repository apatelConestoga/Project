//
//  SettingVC.swift
//  Midterm
//
//  Created by Adeesh on 2024-07-01.
//

import UIKit

class SettingValue {
    var value: String?
    var isSelected: Bool?
    var isAscending: Bool?
    var taskStatus: TaskStatus?
    
    init(value: String? = nil, isSelected: Bool? = nil, isAscending: Bool? = nil, taskStatus: TaskStatus? = .pending) {
        self.value = value
        self.isSelected = isSelected
        self.isAscending = isAscending
        self.taskStatus = taskStatus
    }
}


class SettingVC: UIViewController {

    
    //MARK: - Outlets
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var tblSetting: UITableView!
    
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    //MARK: - Variable
    var arrSort = [SettingValue]()
    var arrStatusFilter = [SettingValue]()
    var arrFilterTask = [Task]()
    var filterValueReturn:(([Task])->())?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableview()
        self.configureDataSource()
        self.btnClear.layer.cornerRadius = 10
        self.btnClear.addDropShadow(shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        self.btnApply.layer.cornerRadius = 10
        self.btnApply.addDropShadow(shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
    }
    
    private func configureTableview() {
        self.tblSetting.delegate = self
        self.tblSetting.dataSource = self
        self.tblSetting.register(UINib(nibName: SettingCell.identiifier, bundle: nil), forCellReuseIdentifier: SettingCell.identiifier)
    }
    
    private func configureDataSource() {
        if self.arrFilterTask.count == 0 {
            self.arrFilterTask = CustomGlobal.shared.retriveItemsFromPreference() ?? []
        }
    
        self.arrSort.append(SettingValue(value: "Date Ascending", isSelected: false, isAscending: true))
        self.arrSort.append(SettingValue(value: "Date Descending", isSelected: false, isAscending: false))
        
        self.arrStatusFilter.append(SettingValue(value: "All Task", isSelected: true, taskStatus: .none))
        self.arrStatusFilter.append(SettingValue(value: "Pending", isSelected: false, taskStatus: .pending))
        self.arrStatusFilter.append(SettingValue(value: "Ongoing", isSelected: false, taskStatus: .ongoing))
        self.arrStatusFilter.append(SettingValue(value: "Completed", isSelected: false, taskStatus: .completed))
        self.btnSort.isSelected = true
        self.btnFilter.isSelected = false
        self.tblSetting.reloadData()
    }
    
}
//MARK: - Button Action
extension SettingVC {
   
    @IBAction func btnSortClicked(_ sender: UIButton) {
        self.btnSort.isSelected = true
        self.btnFilter.isSelected = false
        self.tblSetting.reloadData()
    }
    
    @IBAction func btnFliterClicked(_ sender: UIButton) {
        self.btnFilter.isSelected = true
        self.btnSort.isSelected = false
        self.tblSetting.reloadData()
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearClicked(_ sender: UIButton) {
        self.filterValueReturn?(CustomGlobal.shared.retriveItemsFromPreference() ?? [])
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnApplyClicked(_ sender: UIButton) {
        self.filterValueReturn?(self.doFilter())
        self.navigationController?.popViewController(animated: true)
    }
    
    private func doSorting() -> [Task] {
        let sort = self.arrSort.first(where: { $0.isSelected == true })
        if sort != nil {
            if sort?.isAscending == true {
                self.arrFilterTask = self.arrFilterTask.sorted(by: { $0.dateValue?.compare($1.dateValue ?? Date()) == .orderedDescending })
            } else {
                self.arrFilterTask = self.arrFilterTask.sorted(by: { $0.dateValue?.compare($1.dateValue ?? Date()) == .orderedAscending })
            }
        }
        return self.arrFilterTask
    }
    
    private func doFilter() -> [Task] {
        let filter = self.arrStatusFilter.first(where: { $0.isSelected == true })
        self.arrFilterTask = doSorting()
        if let filter = filter {
            switch filter.taskStatus {
            case .pending:
                self.arrFilterTask = self.arrFilterTask.filter { $0.status == .pending }
            case .completed:
                self.arrFilterTask = self.arrFilterTask.filter { $0.status == .completed }
            case .ongoing:
                self.arrFilterTask = self.arrFilterTask.filter { $0.status == .ongoing }
            case .none:
                return doSorting()
            }
        }
        return self.arrFilterTask
    }
}

//MARK: - Tableview Delegate and DataSource
extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnSort.isSelected {
            return self.arrSort.count
        } else {
            return self.arrStatusFilter.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identiifier, for: indexPath) as? SettingCell else { return UITableViewCell() }
        if btnSort.isSelected {
            cell.cellConfiguration(obj: self.arrSort[indexPath.row])
        } else {
            cell.cellConfiguration(obj: self.arrStatusFilter[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if btnSort.isSelected {
            _ = self.arrSort.map { $0.isSelected = false }
            self.arrSort[indexPath.row].isSelected = true
        } else {
            _ = self.arrStatusFilter.map { $0.isSelected = false }
            self.arrStatusFilter[indexPath.row].isSelected = true
        }
        self.tblSetting.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
