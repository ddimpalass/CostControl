//
//  PeriodsStorage.swift
//  Spend
//
//  Created by Apple on 18.05.2021.
//

//import Combine
//import CoreData
//
//class PeriodsStorage: NSObject, ObservableObject {
//    @Published var periods: [Period] = []
//    private let periodFetchController: NSFetchedResultsController<Period>
//
//    init(managedObjectContext: NSManagedObjectContext) {
//        let sort = NSSortDescriptor(key: "startDate", ascending: true)
//        let periodFetchRequest: NSFetchRequest<Period> = Period.fetchRequest()
//        periodFetchRequest.sortDescriptors = [sort]
//        
//        periodFetchController = NSFetchedResultsController(
//            fetchRequest: periodFetchRequest,
//            managedObjectContext: managedObjectContext,
//            sectionNameKeyPath: nil, cacheName: nil
//        )
//        
//        super.init()
//        
//        periodFetchController.delegate = self
//        
//        do {
//            try periodFetchController.performFetch()
//            periods = periodFetchController.fetchedObjects ?? []
//        } catch {
//            print("failed to fetch items!")
//        }
//    }
//    
//    func save(completion: @escaping (Error?) -> () = {_ in}) {
//        let context = PersistenceController.shared.container.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//                completion(nil)
//            } catch  {
//                completion(error)
//            }
//        }
//    }
//    
//    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
//        let context = PersistenceController.shared.container.viewContext
//        context.delete(object)
//        save(completion: completion )
//    }
//}
//
//extension PeriodsStorage: NSFetchedResultsControllerDelegate {
//    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        guard let periods = controller.fetchedObjects as? [Period] else { return }
//        self.periods = periods
//    }
//}

