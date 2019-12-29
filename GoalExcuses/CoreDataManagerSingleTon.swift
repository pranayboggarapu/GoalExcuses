//
//  CoreDataManagerSingleTon.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/25/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import CoreData


struct CoreDataManagerSingleton {
    
    static let shared = CoreDataManagerSingleton()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoalSharing")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of Goal Data failed \(error)")
            }
        }
        return container
    }()
}
