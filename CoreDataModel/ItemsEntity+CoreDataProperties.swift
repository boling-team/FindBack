//
//  ItemsEntity+CoreDataProperties.swift
//  BagLocation
//
//  Created by Jonathan Lee on 20/05/22.
//
//

import Foundation
import CoreData


extension ItemsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemsEntity> {
        return NSFetchRequest<ItemsEntity>(entityName: "ItemsEntity")
    }

    @NSManaged public var itemID: UUID?
    @NSManaged public var itemName: String?
    @NSManaged public var compartment: CompartmentsEntity?

}

extension ItemsEntity : Identifiable {

}
