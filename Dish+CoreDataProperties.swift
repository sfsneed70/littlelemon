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
    @NSManaged public var category: String?
    @NSManaged public var details: String?

}

extension Dish : Identifiable {
    private static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }
    
    static func exists(title: String,
                       _ context:NSManagedObjectContext) -> Bool? {
        let request = Dish.request()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
            else {
                return nil
            }
            return results.count > 0
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    
    class func deleteAll(_ context:NSManagedObjectContext) {
        let request = Dish.request()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
            try persistentStoreCoordinator.execute(deleteRequest, with: context)
            //try? context.save()

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    class func createDishesFrom(menuItems:[MenuItem],
                                _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            if !Dish.exists(title: menuItem.title, context)!{
                let newMenuItem = Dish(context: context)
                newMenuItem.title = menuItem.title
                newMenuItem.price = menuItem.price
                newMenuItem.image = menuItem.image
                newMenuItem.category = menuItem.category
                newMenuItem.details = menuItem.description            }
        }
    }
}
