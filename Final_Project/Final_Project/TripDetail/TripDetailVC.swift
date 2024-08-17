//
//  TripDetailVC.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-17.
//

import UIKit

class TripDetailVC: UIViewController {

    
    @IBOutlet weak var imgTrip: UIImageView!
    @IBOutlet weak var viewWeather: UIView!
    
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWeatherType: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    
    @IBOutlet weak var lblTripName: UILabel!
    @IBOutlet weak var lblBudget: UILabel!
    @IBOutlet weak var lblOriginAddress: UILabel!
    @IBOutlet weak var viewDash: UIView!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnManageExpenses: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewDash.drawVerticalDottedLine(atX: self.viewDash.bounds.midX,
                                        startY: self.viewDash.bounds.minY,
                                        endY: self.viewDash.bounds.maxY)


    }
    

    @IBAction func btnManageExpensesPressed(_ sender: UIButton) {
        self.redirectToManageExpenses()
    }
    

}

//MARK: - Navigation
extension TripDetailVC {
    
    func redirectToManageExpenses() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ManageExpensesVC") as! ManageExpensesVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
