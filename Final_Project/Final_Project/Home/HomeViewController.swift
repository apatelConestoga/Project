//
//  HomeViewController.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-10.
//

import UIKit

struct SuggestedTrip {
    var tripName: String
    var tripDate: String
    var totalDays: String
    var isMostRated: Bool
    var tripImage: String
}

class HomeViewController: UIViewController {

    @IBOutlet weak var btnAddTrip: UIBarButtonItem!
    @IBOutlet weak var viewSearch: UIView!

    @IBOutlet weak var viewSuggested: UIView!
    @IBOutlet weak var collSuggested: UICollectionView!
    
    @IBOutlet weak var viewOngoing: UIView!
    @IBOutlet weak var lblTrip: UILabel!
    @IBOutlet weak var imgOngoing: UIImageView!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var viewDash: UIView!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblTotalBudget: UILabel!
    @IBOutlet weak var btnTripDetail: UIButton!
    
    @IBOutlet weak var viewUpcoming: UIView!
    @IBOutlet weak var collUpcoming: UICollectionView!
    
    @IBOutlet weak var viewRecent: UIView!
    @IBOutlet weak var collRecent: UICollectionView!
    
    
    var arrSuggestedTrip = [SuggestedTrip]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureOutlets()
        self.configureDataSourceForSuggestedTrip()
        self.configureCollectionViews()
    }
    
    private func configureOutlets() {
        self.viewSearch.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor)
        viewDash.drawDottedLine(start: CGPoint(x: self.viewDash.bounds.minX, y: self.viewDash.bounds.minY), end: CGPoint(x: self.viewDash.bounds.maxX, y: self.viewDash.bounds.minY))
    }
    
    private func configureCollectionViews() {
        self.collSuggested.delegate = self
        self.collSuggested.dataSource = self
        self.collSuggested.register(SuggestedCVC.nib, forCellWithReuseIdentifier: SuggestedCVC.identifier)
        
        let suggestedFlowLayout = UICollectionViewFlowLayout()
        let cellWidth = self.collSuggested.frame.width * 0.8
        suggestedFlowLayout.itemSize = CGSize(width: cellWidth, height: self.collSuggested.frame.height)
        suggestedFlowLayout.minimumLineSpacing = 10
        suggestedFlowLayout.scrollDirection = .horizontal
        suggestedFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        self.collSuggested.setCollectionViewLayout(suggestedFlowLayout, animated: true)
        
        self.collUpcoming.delegate = self
        self.collUpcoming.dataSource = self
        self.collUpcoming.register(UpcomingTripCVC.nib, forCellWithReuseIdentifier: UpcomingTripCVC.identifier)
        
        let upcomingFlowLayout = UICollectionViewFlowLayout()
        let upcomingCellWidth = self.collUpcoming.frame.width * 0.4
        upcomingFlowLayout.itemSize = CGSize(width: upcomingCellWidth, height: self.collUpcoming.frame.height)
        upcomingFlowLayout.minimumLineSpacing = 10
        upcomingFlowLayout.scrollDirection = .horizontal
        upcomingFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        self.collUpcoming.setCollectionViewLayout(upcomingFlowLayout, animated: true)
        
        
        self.collRecent.delegate = self
        self.collRecent.dataSource = self
        self.collRecent.register(RecentCVC.nib, forCellWithReuseIdentifier: RecentCVC.identifier)
        
        let recentFlowLayout = UICollectionViewFlowLayout()
        let recentCellWidth = self.collRecent.frame.width * 0.8
        recentFlowLayout.itemSize = CGSize(width: recentCellWidth, height: self.collRecent.frame.height)
        recentFlowLayout.minimumLineSpacing = 10
        recentFlowLayout.scrollDirection = .horizontal
        recentFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        self.collRecent.setCollectionViewLayout(recentFlowLayout, animated: true)
    }
    
    private func configureDataSourceForSuggestedTrip() {
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "Jaipur", tripDate: "30th August 2024", totalDays: "10 Days", isMostRated: true, tripImage: "jaipur"))
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "Dubai", tripDate: "10th Sepetember 2024", totalDays: "5 Days", isMostRated: true, tripImage: "dubai"))
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "London", tripDate: "15th Sepetember 2024", totalDays: "7 Days", isMostRated: false, tripImage: "london"))
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "New Delhi", tripDate: "12th Sepetember 2024", totalDays: "9 Days", isMostRated: false, tripImage: "newDelhi"))
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "Spain", tripDate: "22nd Sepetember 2024", totalDays: "15 Days", isMostRated: true, tripImage: "spain"))
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "Victoria", tripDate: "1st October 2024", totalDays: "20 Days", isMostRated: true, tripImage: "victoria"))
    }
}

//MARK:- Action Methods
extension HomeViewController {
    @IBAction func btnAddTripPressed(_ sender: UIBarButtonItem) {
        self.redirectToAddTrip()
    }
    
    @IBAction func btnSearchPressed(_ sender: UIButton) {
        self.redirectToTripList()
    }
    
    @IBAction func btnTripDetailPressed(_ sender: UIButton) {
    }
}
//MARK: - Collection View Delegate and Data Source
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collSuggested:
            return self.arrSuggestedTrip.count
        case self.collUpcoming:
            return self.arrSuggestedTrip.count
        default:
            return self.arrSuggestedTrip.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.collSuggested:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestedCVC.identifier, for: indexPath) as? SuggestedCVC else { return UICollectionViewCell()}
            cell.configureCell(value: self.arrSuggestedTrip[indexPath.item])
            return cell
        case self.collUpcoming:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingTripCVC.identifier, for: indexPath) as? UpcomingTripCVC else { return UICollectionViewCell()}
            cell.configureCell(value: self.arrSuggestedTrip[indexPath.item])
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCVC.identifier, for: indexPath) as? RecentCVC else { return UICollectionViewCell()}
            cell.configureCell(value: self.arrSuggestedTrip[indexPath.item])
            return cell
        }
    }
}

//MARK: - Navigation
extension HomeViewController {
    func redirectToAddTrip() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "AddTripViewController") as! AddTripViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func redirectToTripList() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TripListViewController") as! TripListViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
