//
//  TaskListVC.swift
//  Midterm
//
//  Created by Adeesh on 2024-06-28.
//

import UIKit

class TaskListVC: UIViewController {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var tblList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
    
    private func configureTableView() {
        self.tblList.delegate = self
        self.tblList.dataSource = self
        
        self.tblList.register(UINib(nibName: "listCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        
//        self.tblList.register(UINib(nibName: <#T##String#>, bundle: <#T##Bundle?#>), forCellReuseIdentifier: "cell")
    }
}

extension TaskListVC {
    @IBAction func btnFliterClicked(_ sender: UIButton) {
        
    }
}

extension TaskListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
