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
            /*
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
             */
            Image(dish.image ?? "").resizable().frame(width: 100, height: 100)
            HStack {
                Text("\(dish.title ?? "")").font(.custom(
                    "SanFranciscoText-Regular",
                    fixedSize: 20)).foregroundStyle(Color.secondaryBlack).padding(.horizontal)
                
                Spacer()
                
                Text("$\(dish.price ?? "")")
                    .font(.custom(
                        "SanFranciscoText-Regular",
                        fixedSize: 20)).foregroundStyle(Color.secondaryBlack).padding(.horizontal)
            }.padding()
            //Text("\(dish.category ?? "")")
            Text("\(dish.details ?? "")").font(.custom(
                "SanFranciscoText-Regular",
                fixedSize: 18)).foregroundStyle(Color.secondaryBlack).padding(.horizontal)

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
        //dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        dish.image = "greeksalad"
        dish.category = "starters"
        dish.details = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
        return dish
    }
}
