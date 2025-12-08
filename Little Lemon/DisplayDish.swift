//
//  DisplayDish.swift
//  Little Lemon
//
//  Created by Stephen Sneed on 12/4/25.
//


import SwiftUI
import CoreData

struct DisplayDish: View {
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 250, height: 250)
            HStack {
                Text("\(dish.title ?? "")")
                    .padding([.top, .bottom], 7)
                
                Spacer()
                
                Text("$\(dish.price ?? "")")
                    .monospaced()
                    .font(.callout)
            }
            Text("\(dish.category ?? "")")
            Text("\(dish.details ?? "")")

        }.contentShape(Rectangle()) // keep this code
    }
}

struct DisplayDish_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        DisplayDish(oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.title = "Greek Salad"
        dish.price = "10"
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        dish.category = "starters"
        dish.details = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
        return dish
    }
}
