//
//  TripCalculation+CoreDataProperties.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-18.
//
//

import Foundation
import CoreData


extension TripCalculation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripCalculation> {
        return NSFetchRequest<TripCalculation>(entityName: "TripCalculation")
    }

    @NSManaged public var amount: Double
    @NSManaged public var expenseTitle: String?
    @NSManaged public var tripDetails: TripDetails?

}

extension TripCalculation : Identifiable {

}
