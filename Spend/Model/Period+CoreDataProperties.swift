//
//  Period+CoreDataProperties.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//
//

import Foundation
import CoreData


extension Period {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Period> {
        return NSFetchRequest<Period>(entityName: "Period")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var limit: Int32
    @NSManaged public var name: String?
    @NSManaged public var spends: NSSet?
    
    public var spendsArray: [Spend] {
        let set = spends as? Set<Spend> ?? []
        return Array(set)
    }

}

// MARK: Generated accessors for spends
extension Period {

    @objc(addSpendsObject:)
    @NSManaged public func addToSpends(_ value: Spend)

    @objc(removeSpendsObject:)
    @NSManaged public func removeFromSpends(_ value: Spend)

    @objc(addSpends:)
    @NSManaged public func addToSpends(_ values: NSSet)

    @objc(removeSpends:)
    @NSManaged public func removeFromSpends(_ values: NSSet)

}

extension Period : Identifiable {

}
