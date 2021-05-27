//
//  SpendStorageManager.swift
//  Spend
//
//  Created by Apple on 21.05.2021.
//

import Combine
import CoreData

class SpendStorageManager: NSObject, ObservableObject {
    var spends = CurrentValueSubject<[Spend], Never>([])
    private let spendFetchController: NSFetchedResultsController<Spend>
    
    static let shared: SpendStorageManager = SpendStorageManager()

    private override init() {
        
        let sort = NSSortDescriptor(key: "date", ascending: true)
        let spendFetchRequest: NSFetchRequest<Spend> = Spend.fetchRequest()
        spendFetchRequest.sortDescriptors = [sort]

        spendFetchController = NSFetchedResultsController(
            fetchRequest: spendFetchRequest,
            managedObjectContext: PersistenceController.shared.container.viewContext,
            sectionNameKeyPath: nil, cacheName: nil
        )

        super.init()

        spendFetchController.delegate = self

        do {
            try spendFetchController.performFetch()
            spends.value = spendFetchController.fetchedObjects ?? []
        } catch {
            print("Failed to fetch spends!")
        }
    }

    
    func addSpend(period: Period, name: String, cost: String) {
        let newSpend = Spend(context: spendFetchController.managedObjectContext)
        newSpend.id = UUID()
        newSpend.name = name
        newSpend.cost = Int32(cost) ?? 0
        newSpend.date = Date()
        period.addToSpends(newSpend)
        
        if spendFetchController.managedObjectContext.hasChanges {
            do {
                try spendFetchController.managedObjectContext.save()
            } catch  {
                print("Error")
            }
        }
    }
    
    func updateSpend(spend: Spend, name: String, cost: String) {
        spend.name = name
        spend.cost = Int32(cost) ?? 0
        
        do {
            try spendFetchController.managedObjectContext.save()
        } catch  {
            spendFetchController.managedObjectContext.rollback()
            print("Error")
        }
    }

    func deleteSpend(spend: Spend) {
        spendFetchController.managedObjectContext.delete(spend)
        
        do {
            try spendFetchController.managedObjectContext.save()
        } catch  {
            spendFetchController.managedObjectContext.rollback()
            print("Error")
        }
    }
}

extension SpendStorageManager: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let spends = controller.fetchedObjects as? [Spend] else { return }
        self.spends.value = spends
    }
}
