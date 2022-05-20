//
//  CompartmentsEntity+CoreDataProperties.swift
//  BagLocation
//
//  Created by Jonathan Lee on 20/05/22.
//
//

import Foundation
import CoreData


extension CompartmentsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompartmentsEntity> {
        return NSFetchRequest<CompartmentsEntity>(entityName: "CompartmentsEntity")
    }

    @NSManaged public var compartmentID: UUID?
    @NSManaged public var compartmentImage: Data?
    @NSManaged public var compartmentName: String?
    @NSManaged public var bag: BagsEntity?
    @NSManaged public var items: NSSet?
    
    public var itemList: [ItemsEntity] {
        get {
            let setOfItems = items as? Set<ItemsEntity> ?? []
            return setOfItems.sorted{
                $0.itemName! < $1.itemName!
            }
        }
    }

}

// MARK: Generated accessors for items
extension CompartmentsEntity {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ItemsEntity)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ItemsEntity)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension CompartmentsEntity : Identifiable {

}
