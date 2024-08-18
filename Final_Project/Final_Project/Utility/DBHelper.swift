//
//  DBHelper.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-11.
//

import UIKit
import CoreData
import CoreLocation

class DBHelper: NSObject {
    
    var managedContext:NSManagedObjectContext? = nil
    let appDelegate:AppDelegate?
//    let idGenerator = IDGenerator()
    
    override init()
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
    }
    
    func getFetchRequest(entityName: String) -> NSFetchRequest<NSManagedObject>
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        return fetchRequest
    }
    
    func getTrip(byID tripID: Int16? = nil, searchQuery: String?) -> [TripDetails] {
        do {
            let fetchRequest = self.getFetchRequest(entityName: "TripDetails")
            
            // Sort by startDate in ascending order
            let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            // Create an array to hold predicates
            var predicates = [NSPredicate]()
            
            // Apply ID predicate if an ID is provided
            if let tripID = tripID {
                predicates.append(NSPredicate(format: "tripId == %d", tripID))
            }
            
            // Apply search predicate if a search query is provided
            if let query = searchQuery, !query.isEmpty {
                predicates.append(NSPredicate(format: "name CONTAINS[cd] %@", query))
            }
            
            // Combine all predicates if any
            if !predicates.isEmpty {
                fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            }
            
            // Execute the fetch request
            let arrTripDetail = try managedContext?.fetch(fetchRequest) as! [TripDetails]
            
            return arrTripDetail
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }

    
    func getTodayTrip() -> [TripDetails] {
        do {
            let fetchRequest = self.getFetchRequest(entityName: "TripDetails")
            
            // Get today's date
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: Date())
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            
            // Set predicate to filter trips with startDate within today
            fetchRequest.predicate = NSPredicate(format: "startDate >= %@ AND startDate < %@", startOfDay as NSDate, endOfDay as NSDate)
            
            let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            let todayTrips = try managedContext?.fetch(fetchRequest) as! [TripDetails]
            
            return todayTrips
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func getUpcomingTrip() -> [TripDetails] {
        do {
            let fetchRequest = self.getFetchRequest(entityName: "TripDetails")
            
            let startOfDay = Date()
            fetchRequest.predicate = NSPredicate(format: "startDate > %@", startOfDay as NSDate)
                    
            let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            let todayTrips = try managedContext?.fetch(fetchRequest) as! [TripDetails]
            
            return todayTrips
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func getRecentTrip() -> [TripDetails] {
        do {
            let fetchRequest = self.getFetchRequest(entityName: "TripDetails")
            
            // Get today's date at the start of the day
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: Date())
            
            // Predicate to filter trips that have a startDate earlier than today
            fetchRequest.predicate = NSPredicate(format: "startDate < %@", startOfDay as NSDate)
            
            // Sort in descending order to get the most recent past trips first
            let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            let pastTrips = try managedContext?.fetch(fetchRequest) as! [TripDetails]
            
            return pastTrips
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func updateTripData(objTrip: TripDetails, tripName: String, tripOriginFullAddress: String, tripOriginLocality: String, tripOriginLocation: CLLocationCoordinate2D, tripDestinationFullAddress: String, tripDestinationLocality: String, tripDestinationLocation: CLLocationCoordinate2D, tripStartDate: Date, tripEndDate: Date, totalBudget: String, tripImage: UIImage, tripDescription: String, success successBlock: ((Bool) -> Void))
    {
        objTrip.name = tripName
        objTrip.originLocation = tripOriginFullAddress
        objTrip.originLocality = tripOriginLocality
        objTrip.originLatitude = Double(tripOriginLocation.latitude)
        objTrip.originLongitude = Double(tripOriginLocation.longitude)
        
        objTrip.destinationLocation = tripDestinationFullAddress
        objTrip.destinationLocality = tripDestinationLocality
        objTrip.destinationLatitude = Double(tripDestinationLocation.latitude)
        objTrip.destinationLongitude = Double(tripDestinationLocation.longitude)
        
        objTrip.startDate = tripStartDate
        objTrip.endDate = tripEndDate
        objTrip.totalBudget = totalBudget
        objTrip.tripDescripation = tripDescription
        objTrip.tripImage = tripImage.jpegData(compressionQuality: 0.75)
        
        do {
            try managedContext?.save()
            successBlock(true)
            let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
            print("\(path)")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            successBlock(false)
        }
    }
    
    
    func addNewTrip(tripName: String, tripOriginFullAddress: String, tripOriginLocality: String, tripOriginLocation: CLLocationCoordinate2D, tripDestinationFullAddress: String, tripDestinationLocality: String, tripDestinationLocation: CLLocationCoordinate2D, tripStartDate: Date, tripEndDate: Date, totalBudget: String, tripImage: UIImage, tripDescription: String, success successBlock:((Bool) -> Void))
    {
        let entity = NSEntityDescription.entity(forEntityName: "TripDetails", in: managedContext!)!
        let tripDetail = NSManagedObject(entity: entity, insertInto: managedContext) as! TripDetails
        tripDetail.tripId = Int16((self.getTrip(searchQuery: nil).count + 1))
        tripDetail.name = tripName
        tripDetail.originLocation = tripOriginFullAddress
        tripDetail.originLocality = tripOriginLocality
        tripDetail.originLatitude = Double(tripOriginLocation.latitude)
        tripDetail.originLongitude = Double(tripOriginLocation.longitude)
        
        tripDetail.destinationLocation = tripDestinationFullAddress
        tripDetail.destinationLocality = tripDestinationLocality
        tripDetail.destinationLatitude = Double(tripDestinationLocation.latitude)
        tripDetail.destinationLongitude = Double(tripDestinationLocation.longitude)
        
        tripDetail.startDate = tripStartDate
        tripDetail.endDate = tripEndDate
        tripDetail.totalBudget = totalBudget
        tripDetail.tripDescripation = tripDescription
        tripDetail.tripImage = tripImage.jpegData(compressionQuality: 0.75)
        
        do {
            try managedContext?.save()
            successBlock(true)
            let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
            print("\(path)")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            successBlock(false)
        }
    }
    
    func deleteTrip(trip: TripDetails, success successBlock: ((Bool) -> Void)? = nil) {
        guard let managedContext = self.managedContext else {
            print("Managed Context is nil")
            successBlock?(false)
            return
        }
        
        // Delete the trip from the context
        managedContext.delete(trip)
        
        // Save the context to persist the deletion
        do {
            try managedContext.save()
            successBlock?(true)
            print("Trip deleted successfully.")
        } catch let error as NSError {
            print("Could not save after deleting. \(error), \(error.userInfo)")
            successBlock?(false)
        }
    }
    
    func getExpenses(for trip: TripDetails) -> [TripCalculation] {
        do {
            let fetchRequest: NSFetchRequest<TripCalculation> = TripCalculation.fetchRequest()
            
            // Set a predicate to filter the expenses by the specific trip
            fetchRequest.predicate = NSPredicate(format: "tripDetails == %@", trip)
            
            // Fetch the expenses from the managed context
            let expenses = try managedContext?.fetch(fetchRequest) as? [TripCalculation] ?? []
            
            return expenses
        } catch let error as NSError {
            print("Could not fetch expenses. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func addNewExpenses(tripDetail: TripDetails, amount: Double, expenseTitle: String, success successBlock:((Bool) -> Void))
    {
        let entity = NSEntityDescription.entity(forEntityName: "TripCalculation", in: managedContext!)!
        let tripCalculation = NSManagedObject(entity: entity, insertInto: managedContext) as! TripCalculation
        tripCalculation.amount = amount
        tripCalculation.expenseTitle = expenseTitle
        
        tripDetail.addToTripCalculation(tripCalculation)
        
        do {
            try managedContext?.save()
            successBlock(true)
            let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
            print("\(path)")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            successBlock(false)
        }
    }
    
    func deleteExpense(expense: TripCalculation, success successBlock: ((Bool) -> Void)? = nil) {
        guard let managedContext = self.managedContext else {
            print("Managed Context is nil")
            successBlock?(false)
            return
        }
        
        // Delete the expense from the context
        managedContext.delete(expense)
        
        // Save the context to persist the deletion
        do {
            try managedContext.save()
            successBlock?(true)
            print("Expense deleted successfully.")
        } catch let error as NSError {
            print("Could not save after deleting. \(error), \(error.userInfo)")
            successBlock?(false)
        }
    }
}

//class IDGenerator {
//    private var currentID = DBHelper().getTrip(searchQuery: nil).count
//
//    func generateID() -> Int {
//        currentID += 1
//        return currentID
//    }
//}
