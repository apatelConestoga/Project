//
//  TripDetails+CoreDataProperties.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-18.
//
//

import Foundation
import CoreData


extension TripDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripDetails> {
        return NSFetchRequest<TripDetails>(entityName: "TripDetails")
    }

    @NSManaged public var destinationLatitude: Double
    @NSManaged public var destinationLocality: String?
    @NSManaged public var destinationLocation: String?
    @NSManaged public var destinationLongitude: Double
    @NSManaged public var endDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var originLatitude: Double
    @NSManaged public var originLocality: String?
    @NSManaged public var originLocation: String?
    @NSManaged public var originLongitude: Double
    @NSManaged public var startDate: Date?
    @NSManaged public var totalBudget: String?
    @NSManaged public var tripDescripation: String?
    @NSManaged public var tripImage: Data?
    @NSManaged public var tripId: Int16
    @NSManaged public var tripCalculation: NSSet?

}

// MARK: Generated accessors for tripCalculation
extension TripDetails {

    @objc(addTripCalculationObject:)
    @NSManaged public func addToTripCalculation(_ value: TripCalculation)

    @objc(removeTripCalculationObject:)
    @NSManaged public func removeFromTripCalculation(_ value: TripCalculation)

    @objc(addTripCalculation:)
    @NSManaged public func addToTripCalculation(_ values: NSSet)

    @objc(removeTripCalculation:)
    @NSManaged public func removeFromTripCalculation(_ values: NSSet)

}

extension TripDetails : Identifiable {

}
