//
//  MenuModel.swift
//  Little Lemon
//
//  Created by Stephen Sneed on 12/8/25.
//

import Foundation
import CoreData
import Combine


@MainActor
class MenuModel: ObservableObject  {
    
    @Published var menuItems = [MenuItem]()
        
    

    
    func reload(_ viewContext:NSManagedObjectContext) {
        // populate Core Data
        Dish.deleteAll(viewContext)
        
        if !Dish.exists(title: "Greek Salad", viewContext)!{
            let Dish1 = Dish(context: viewContext)
            Dish1.title = "Greek Salad"
            Dish1.price = "12"
            Dish1.image = "greeksalad"
            Dish1.details = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
            Dish1.category = "starters"
        }
        
        if !Dish.exists(title: "Lemon Desert", viewContext)!{
            let Dish1 = Dish(context: viewContext)
            Dish1.title = "Lemon Desert"
            Dish1.price = "10"
            Dish1.image = "lemoncake"
            Dish1.details = "Traditional homemade Italian Lemon Ricotta Cake."
            Dish1.category = "desserts"
        }
        
        if !Dish.exists(title: "Grilled Fish", viewContext)!{
            let Dish1 = Dish(context: viewContext)
            Dish1.title = "Grilled Fish"
            Dish1.price = "25"
            Dish1.image = "grilledfish"
            Dish1.details = "Barbequed catch of the day with red oninion, crisp capers, chive creme fraiche, and potatoes."
            Dish1.category = "mains"
        }
        
        if !Dish.exists(title: "Pasta", viewContext)!{
            let Dish1 = Dish(context: viewContext)
            Dish1.title = "Pasta"
            Dish1.price = "20"
            Dish1.image = "grilledfish"
            Dish1.details = "Penne with fried aubergines, cherry tomatoes, tomato sauce, fresh chilli, garlic, basil & salted ricotta cheese."
            Dish1.category = "mains"
        }
        
        if !Dish.exists(title: "Bruschetta", viewContext)!{
            let Dish1 = Dish(context: viewContext)
            Dish1.title = "Bruschetta"
            Dish1.price = "10"
            Dish1.image = "bruschetta"
            Dish1.details = "Oven-baked bruschetta stuffed with tomatos and herbs."
            Dish1.category = "starters"
        }
        
        if !Dish.exists(title: "Iced Tea", viewContext)!{
            let Dish1 = Dish(context: viewContext)
            Dish1.title = "Iced Tea"
            Dish1.price = "6"
            Dish1.image = "icedtea"
            Dish1.details = "Fresh brewed strawberry, peach, or original."
            Dish1.category = "drinks"
        }
        
        if !Dish.exists(title: "Creme Brulee", viewContext)!{
            let Dish1 = Dish(context: viewContext)
            Dish1.title = "Creme Brulee"
            Dish1.price = "10"
            Dish1.image = "cremebrulee"
            Dish1.details = "Traditional french vanilla cream dessert with caramelized sugar."
            Dish1.category = "desserts"
        }
        
        if !Dish.exists(title: "Negroni", viewContext)!{
            let Dish1 = Dish(context: viewContext)
            Dish1.title = "Negroni"
            Dish1.price = "12"
            Dish1.image = "negroni"
            Dish1.details = "Classic bitter-sweet Italian aperitif cocktail."
            Dish1.category = "drinks"
        }
    }
}

