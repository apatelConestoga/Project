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

    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewSuggested: UIView!
    @IBOutlet weak var collSuggested: UICollectionView!
    @IBOutlet weak var viewOngoing: UIView!
    @IBOutlet weak var collOngoing: UICollectionView!
    @IBOutlet weak var viewUpcoming: UIView!
    @IBOutlet weak var collUpcoming: UICollectionView!
    @IBOutlet weak var viewRecent: UIView!
    @IBOutlet weak var collRecent: UICollectionView!
    
    
    var arrSuggestedTrip = [SuggestedTrip]()
    var arrOngoing = [TripDetails]()
    var arrUpcoming = [TripDetails]()
    var arrRecent = [TripDetails]()
    let objDBHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureOutlets()
        self.configureDataSourceForSuggestedTrip()
        self.configureCollectionViews()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("AddNewTrip"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchOngoingTrip()
        self.fetchUpcomingTrip()
        self.fetchRecentTrip()
    }
    
    private func configureOutlets() {
        self.viewSearch.addDropShadow(shadowColor: UIColor.appColor(.textBlack)?.cgColor)
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
        suggestedFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.collSuggested.setCollectionViewLayout(suggestedFlowLayout, animated: true)
        
        self.collUpcoming.delegate = self
        self.collUpcoming.dataSource = self
        self.collUpcoming.register(UpcomingTripCVC.nib, forCellWithReuseIdentifier: UpcomingTripCVC.identifier)
        
        let upcomingFlowLayout = UICollectionViewFlowLayout()
        let upcomingCellWidth = self.collUpcoming.frame.width * 0.5
        upcomingFlowLayout.itemSize = CGSize(width: upcomingCellWidth, height: self.collUpcoming.frame.height)
        upcomingFlowLayout.minimumLineSpacing = 10
        upcomingFlowLayout.scrollDirection = .horizontal
        upcomingFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.collUpcoming.setCollectionViewLayout(upcomingFlowLayout, animated: true)
        
        
        self.collRecent.delegate = self
        self.collRecent.dataSource = self
        self.collRecent.register(RecentCVC.nib, forCellWithReuseIdentifier: RecentCVC.identifier)
        
        let recentFlowLayout = UICollectionViewFlowLayout()
        let recentCellWidth = self.collRecent.frame.width * 0.8
        recentFlowLayout.itemSize = CGSize(width: recentCellWidth, height: self.collRecent.frame.height)
        recentFlowLayout.minimumLineSpacing = 10
        recentFlowLayout.scrollDirection = .horizontal
        recentFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.collRecent.setCollectionViewLayout(recentFlowLayout, animated: true)
        
        self.collOngoing.delegate = self
        self.collOngoing.dataSource = self
        self.collOngoing.register(OngoingCVC.nib, forCellWithReuseIdentifier: OngoingCVC.identifier)
        
        let ongoingFlowLayout = UICollectionViewFlowLayout()
        let ongoingCellWidth = self.collOngoing.frame.width * 0.8
        ongoingFlowLayout.itemSize = CGSize(width: ongoingCellWidth, height: self.collOngoing.frame.height)
        ongoingFlowLayout.minimumLineSpacing = 10
        ongoingFlowLayout.scrollDirection = .horizontal
        ongoingFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.collOngoing.setCollectionViewLayout(ongoingFlowLayout, animated: true)
    }
    
    private func configureDataSourceForSuggestedTrip() {
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "Jaipur", tripDate: "30th August 2024", totalDays: "10 Days", isMostRated: true, tripImage: "jaipur"))
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "Dubai", tripDate: "10th Sepetember 2024", totalDays: "5 Days", isMostRated: true, tripImage: "dubai"))
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "London", tripDate: "15th Sepetember 2024", totalDays: "7 Days", isMostRated: false, tripImage: "london"))
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "New Delhi", tripDate: "12th Sepetember 2024", totalDays: "9 Days", isMostRated: false, tripImage: "newDelhi"))
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "Spain", tripDate: "22nd Sepetember 2024", totalDays: "15 Days", isMostRated: true, tripImage: "spain"))
        self.arrSuggestedTrip.append(SuggestedTrip(tripName: "Victoria", tripDate: "1st October 2024", totalDays: "20 Days", isMostRated: true, tripImage: "victoria"))
    }
    
    func fetchOngoingTrip() {
        self.arrOngoing = self.objDBHelper.getTodayTrip()
        if self.arrOngoing.count > 0 {
            self.viewOngoing.isHidden = false
            self.collOngoing.reloadData()
        } else {
            self.viewOngoing.isHidden = true
        }
    }
    
    func fetchUpcomingTrip() {
        self.arrUpcoming = self.objDBHelper.getUpcomingTrip()
        if self.arrUpcoming.count > 0 {
            self.viewUpcoming.isHidden = false
            self.collUpcoming.reloadData()
        } else {
            self.viewUpcoming.isHidden = true
        }
    }
    
    func fetchRecentTrip() {
        self.arrRecent = self.objDBHelper.getRecentTrip()
        if self.arrRecent.count > 0 {
            self.viewRecent.isHidden = false
            self.collRecent.reloadData()
        } else {
            self.viewRecent.isHidden = true
        }
    }
}

//MARK:- Action Methods
extension HomeViewController {
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.fetchRecentTrip()
        self.fetchOngoingTrip()
        self.fetchUpcomingTrip()
    }
    
    @IBAction func btnSearchPressed(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 1
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
            return self.arrUpcoming.count
        case self.collOngoing:
            return self.arrOngoing.count
        default:
            return self.arrRecent.count
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
            cell.configureCell(value: self.arrUpcoming[indexPath.item])
            return cell
        case self.collOngoing:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OngoingCVC.identifier, for: indexPath) as? OngoingCVC else { return UICollectionViewCell()}
            cell.configureCell(value: self.arrOngoing[indexPath.item])
            cell.onClickTripDetailPressed = { [weak self] id in
                self?.redirectToTripDetail(tripId: id)
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCVC.identifier, for: indexPath) as? RecentCVC else { return UICollectionViewCell()}
            cell.configureCell(value: self.arrRecent[indexPath.item])
            return cell
        }
    }
}

//MARK: - Navigation
extension HomeViewController {
    
    func redirectToTripDetail(tripId: Int16) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TripDetailVC") as! TripDetailVC
        viewController.tripId = tripId
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
