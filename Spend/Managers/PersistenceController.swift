//
//  PersistenceController.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//

import CoreData

struct PersistenceController {

    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "Spend")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
