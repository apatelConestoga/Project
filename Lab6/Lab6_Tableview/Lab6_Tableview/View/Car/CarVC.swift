//
//  CarVC.swift
//  Lab6_Tableview
//
//  Created by Adeesh on 2024-07-07.
//

import UIKit

class CarVC: UIViewController {

    @IBOutlet weak var tblCars: UITableView!
    
    var arrCars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigation()
        self.configureStaticDataSource()
        self.configureTableview()
    }
    
    private func configureNavigation() {
        self.title = "Car List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCar))
                
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
    }
    
    private func configureStaticDataSource() {
        self.arrCars.append(Car(image: UIImage(named: "car"), make: "Chevrolet", model: "Camero"))
        self.arrCars.append(Car(image: UIImage(named: "car"), make: "Volvo", model: "XC90"))
        self.arrCars.append(Car(image: UIImage(named: "car"), make: "Chevrolet", model: "Corvet"))
        self.arrCars.append(Car(image: UIImage(named: "car"), make: "Honda", model: "Civic"))
        self.arrCars.append(Car(image: UIImage(named: "car"), make: "Audi", model: "TT"))
        self.arrCars.append(Car(image: UIImage(named: "car"), make: "Honda", model: "Accord Hybrid"))
        self.arrCars.append(Car(image: UIImage(named: "car"), make: "Nissan", model: "Altima"))
        self.arrCars.append(Car(image: UIImage(named: "car"), make: "McLaren", model: "Artura"))
        
    }
    
    private func configureTableview() {
        self.tblCars.delegate = self
        self.tblCars.dataSource = self
        self.tblCars.register(UINib(nibName: CarTBL.identifier, bundle: nil), forCellReuseIdentifier: CarTBL.identifier)
    }
    
    
    @objc func addCar() {
        let alert = UIAlertController(title: "New Car", message: "Enter car details", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Car Make"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Car Model"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            var make = ""
            var model = ""
            if let carMake = alert.textFields?.first?.text {
                make = carMake
            }
            
            if let carModel = alert.textFields?.last?.text {
                model = carModel
            }
            
            self.arrCars.append(Car(image: UIImage(named: "car"), make: make, model: model))
            self.tblCars.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func toggleEditMode() {
        self.tblCars.isEditing = !self.tblCars.isEditing
    }
    
    
}

extension CarVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarTBL.identifier, for: indexPath) as? CarTBL else { return UITableViewCell() }
        cell.configureCell(value: self.arrCars[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.arrCars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedCar = arrCars.remove(at: sourceIndexPath.row)
        arrCars.insert(movedCar, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
