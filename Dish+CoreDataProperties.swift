//
//  Dish+CoreDataProperties.swift
//  Little Lemon
//
//  Created by Stephen Sneed on 12/3/25.
//
//

public import Foundation
public import CoreData


public typealias DishCoreDataPropertiesSet = NSSet

extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var price: String?

}

extension Dish : Identifiable {

}
