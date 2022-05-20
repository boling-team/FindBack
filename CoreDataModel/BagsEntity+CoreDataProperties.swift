//
//  BagsEntity+CoreDataProperties.swift
//  BagLocation
//
//  Created by Jonathan Lee on 20/05/22.
//
//

import Foundation
import CoreData


extension BagsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BagsEntity> {
        return NSFetchRequest<BagsEntity>(entityName: "BagsEntity")
    }

    @NSManaged public var bagID: UUID?
    @NSManaged public var bagImage: Data?
    @NSManaged public var bagName: String?
    @NSManaged public var compartments: NSSet?
    
    public var wrappedBagName: String {
        bagName ?? "Unknown Bag"
    }
    
    public var wrappedBagID: UUID {
        bagID ?? UUID()
    }
    
    public var wrappedBagImage: Data {
        bagImage ?? Data()
    }
    
    public var compartmentList: [CompartmentsEntity] {
        let setOfCompartment = compartments as? Set<CompartmentsEntity> ?? []
        
        return setOfCompartment.sorted{
            $0.compartmentName! < $1.compartmentName!
        }
    }
}

// MARK: Generated accessors for compartments
extension BagsEntity {

    @objc(addCompartmentsObject:)
    @NSManaged public func addToCompartments(_ value: CompartmentsEntity)

    @objc(removeCompartmentsObject:)
    @NSManaged public func removeFromCompartments(_ value: CompartmentsEntity)

    @objc(addCompartments:)
    @NSManaged public func addToCompartments(_ values: NSSet)

    @objc(removeCompartments:)
    @NSManaged public func removeFromCompartments(_ values: NSSet)

}

extension BagsEntity : Identifiable {

}
