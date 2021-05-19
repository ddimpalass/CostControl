//
//  StorageManager.swift
//  Spend
//
//  Created by Apple on 19.05.2021.
//

import Combine
import CoreData

class StorageManager: NSObject, ObservableObject {
    var periods = CurrentValueSubject<[Period], Never>([])
    private let periodFetchController: NSFetchedResultsController<Period>
    
    static let shared: StorageManager = StorageManager()

    private override init() {
        
        let sort = NSSortDescriptor(key: "startDate", ascending: true)
        let periodFetchRequest: NSFetchRequest<Period> = Period.fetchRequest()
        periodFetchRequest.sortDescriptors = [sort]

        periodFetchController = NSFetchedResultsController(
            fetchRequest: periodFetchRequest,
            managedObjectContext: PersistenceController.shared.container.viewContext,
            sectionNameKeyPath: nil, cacheName: nil
        )

        super.init()

        periodFetchController.delegate = self

        do {
            try periodFetchController.performFetch()
            periods.value = periodFetchController.fetchedObjects ?? []
        } catch {
            print("failed to fetch items!")
        }
    }

    func addPeriod(name: String, limit: String, numberOfDays: String) {
        
        let newPeriod = Period(context: periodFetchController.managedObjectContext)
        newPeriod.name = name
        newPeriod.limit = Int32(limit) ?? 0
        newPeriod.startDate = Date()
        newPeriod.endDate =  Calendar.current.date(byAdding: .day,
                                                   value: Int(numberOfDays) ?? 0,
                                                   to: newPeriod.startDate ?? Date())

        if periodFetchController.managedObjectContext.hasChanges {
            do {
                try periodFetchController.managedObjectContext.save()
            } catch  {
                print("Error")
            }
        }
    }
    
    func addSpend(period: Period, name: String, cost: String) {
        
        let newSpend = Spend(context: periodFetchController.managedObjectContext)
        newSpend.name = name
        newSpend.cost = Int32(cost) ?? 0
        newSpend.date = Date()
        period.addToSpends(newSpend)
        

        if periodFetchController.managedObjectContext.hasChanges {
            do {
                try periodFetchController.managedObjectContext.save()
            } catch  {
                print("Error")
            }
        }
    }
    
    func updatePeriod(period: Period, name: String, limit: String, numberOfDays: String) {
        period.name = name
        period.limit = Int32(limit) ?? 0
        period.endDate =  Calendar.current.date(byAdding: .day,
                                                   value: Int(numberOfDays) ?? 0,
                                                   to: period.startDate ?? Date())
        
        do {
            try periodFetchController.managedObjectContext.save()
        } catch  {
            periodFetchController.managedObjectContext.rollback()
            print("Error")
        }
    }
    
    func updateSpend(spend: Spend, name: String, cost: String) {
        spend.name = name
        spend.cost = Int32(cost) ?? 0
        
        do {
            try periodFetchController.managedObjectContext.save()
        } catch  {
            periodFetchController.managedObjectContext.rollback()
            print("Error")
        }
    }
    
    func deletePeriod(period: Period) {
        periodFetchController.managedObjectContext.delete(period)
        period.removeFromSpends(period.spends ?? NSSet())
        
        do {
            try periodFetchController.managedObjectContext.save()
        } catch  {
            periodFetchController.managedObjectContext.rollback()
            print("Error")
        }
    }

    func deleteSpend(spend: Spend) {
        periodFetchController.managedObjectContext.delete(spend)
        
        do {
            try periodFetchController.managedObjectContext.save()
        } catch  {
            periodFetchController.managedObjectContext.rollback()
            print("Error")
        }
    }
}

extension StorageManager: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let periods = controller.fetchedObjects as? [Period] else { return }
        self.periods.value = periods
    }
}

