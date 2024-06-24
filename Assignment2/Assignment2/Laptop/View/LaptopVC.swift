//
//  LaptopVC.swift
//  Assignment2
//
//  Created by Adeesh on 2024-06-21.
//

import UIKit

class LaptopVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tblLaptop: UITableView!
    
    //MARK: - Variable
    var arrLaptopList = [LaptopModel]() {
        didSet {
            self.tblLaptop.reloadData()
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigation()
        self.configureTableView()
    }
    
    private func configureNavigation() {
        //Customized navigation
        self.title = "Laptop"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.3568627451, blue: 0.2549019608, alpha: 1)]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 30)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.3568627451, blue: 0.2549019608, alpha: 1)]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.sizeToFit()
        //Add right navigation button
        let plusImage = UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = plusImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = plusImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(addItemsClicked))
        
        //Add left navigation button
        let backImage = UIImage(named: "back-button")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(back))

    }
    
    //Customized table view
    private func configureTableView() {
        self.tblLaptop.delegate = self
        self.tblLaptop.dataSource = self
        self.tblLaptop.contentInsetAdjustmentBehavior = .never
        
        //Add static values
        self.arrLaptopList.append(LaptopModel(title: "Dell", details: "2.7Ghz", price: 1299.99, isStatic: false))
        self.arrLaptopList.append(LaptopModel(title: "Apple", details: "2Ghz", price: 2299.99, isStatic: false))
        self.arrLaptopList.append(LaptopModel(title: "HP", details: "2.3Ghz", price: 299.99, isStatic: false))
        self.addIBMLaptopIfNecessary()
    }
    
    
    //Show alert
    func showAlert() {
        self.showAlertWithInputDialog(title: "Add New Item", subtitle: "", actionTitle: "Ok", cancelTitle: "Cancel") { cancel in
        } actionHandler: { objLaptop, success in
            if success {
                if let objLaptop = objLaptop {
                    //append user values in laptop array
                    self.arrLaptopList.append(objLaptop)
                    self.addIBMLaptopIfNecessary()
                }
            } else {
                //Show error alert
                self.showSimpleAlert(title: "Please enter all details", actionTitle: "Close", alertStyle: .actionSheet) {
                    self.showAlert()
                }
            }
        }
    }
    
    func addIBMLaptopIfNecessary() {
        let studentNumber = "8981509"
        let fifthDigitIndex = studentNumber.index(studentNumber.startIndex, offsetBy: 4)
        guard let fifthDigit = Int(String(studentNumber[fifthDigitIndex])) else {
            return
        }
        
        // Determine the index of the first static laptop in the array
        let index = self.arrLaptopList.firstIndex(where: { $0.isStatic == true })
        
        // Only insert if there's no static laptop already in the array
        if index == nil {
            if fifthDigit <= self.arrLaptopList.count {
                let insertPosition = (fifthDigit == 0) ? fifthDigit : fifthDigit - 1
                self.arrLaptopList.insert(LaptopModel(title: "IBM Tablet (#\(studentNumber))", details: "", price: 999.99, isStatic: true), at: insertPosition)
            }
        }
        
        
    }
}

//MARK: - Button Action
extension LaptopVC {
    //Back action
    @objc func back() {
        self.navigationController?.popViewController(animated:true)
    }
    
    //Add new item action
    @objc func addItemsClicked() {
        self.showAlert()
    }
}

extension LaptopVC: UIScrollViewDelegate {
    //Scroll event
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tblLaptop{
            //Scroll greater than 3 the hide large title
            if self.tblLaptop.contentOffset.y > 3.0 {
                self.navigationController?.navigationBar.prefersLargeTitles = false
            }
            //Scroll equal to 0 the show large title 
            if self.tblLaptop.contentOffset.y == 0.0 {
                self.navigationController?.navigationBar.prefersLargeTitles = true
                self.navigationItem.largeTitleDisplayMode = .automatic
                self.navigationController?.navigationBar.sizeToFit()
            }
        }
    }
}

//MARK: - Table View Delegate and DataSource
extension LaptopVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrLaptopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.arrLaptopList[indexPath.row].isStatic == true {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "staticCell", for: indexPath) as? StaticCell else { return UITableViewCell()}
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "laptopCell", for: indexPath) as? LaptopCell else { return UITableViewCell()}
            
            cell.confgiureCell(object: self.arrLaptopList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.arrLaptopList[indexPath.row].isStatic == true {
            return 70
        } else {
            return 100
        }
    }
}

