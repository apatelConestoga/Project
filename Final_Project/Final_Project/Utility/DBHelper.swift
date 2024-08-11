//
//  DBHelper.swift
//  Final_Project
//
//  Created by Adeesh on 2024-08-11.
//

import UIKit
import CoreData

class DBHelper: NSObject {
    
    var managedContext:NSManagedObjectContext? = nil
    let appDelegate:AppDelegate?
    
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
    
}
