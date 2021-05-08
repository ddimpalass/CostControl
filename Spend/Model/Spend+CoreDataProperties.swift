//
//  Spend+CoreDataProperties.swift
//  Spend
//
//  Created by Дмитрий on 08.05.2021.
//
//

import Foundation
import CoreData


extension Spend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Spend> {
        return NSFetchRequest<Spend>(entityName: "Spend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var cost: Int32
    @NSManaged public var name: String?
    @NSManaged public var period: Period?

}

extension Spend : Identifiable {

}
