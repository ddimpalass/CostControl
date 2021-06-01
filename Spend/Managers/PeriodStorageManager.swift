//
//  StorageManager.swift
//  Spend
//
//  Created by Apple on 19.05.2021.
//

import Combine
import CoreData

class PeriodStorageManager: NSObject, ObservableObject {
    var periods = CurrentValueSubject<[Period], Never>([])
    private let periodFetchController: NSFetchedResultsController<Period>
    
    static let shared: PeriodStorageManager = PeriodStorageManager()

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
            print("Failed to fetch periods!")
        }
    }

    func addPeriod(name: String, limit: String, numberOfDays: String) {
        
        let newPeriod = Period(context: periodFetchController.managedObjectContext)
        newPeriod.id = UUID()
        newPeriod.name = name
        newPeriod.limit = Int32(limit) ?? 0
        newPeriod.startDate = Calendar.current.startOfDay(for: Date())
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
    
    func deletePeriod(period: Period) {
        periodFetchController.managedObjectContext.delete(period)
        
        do {
            try periodFetchController.managedObjectContext.save()
        } catch  {
            periodFetchController.managedObjectContext.rollback()
            print("Error")
        }
    }
}

extension PeriodStorageManager: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let periods = controller.fetchedObjects as? [Period] else { return }
        self.periods.value = periods
    }
}

