//
//  Menu.swift
//  Little Lemon
//
//  Created by Stephen Sneed on 11/20/25.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("Online Restaurant Application")
            FetchedObjects() {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes, id:\.self) { dish in
                        HStack {
                            Text("\(dish.title ?? "") - $\(dish.price ?? "0.00")")
                            
                        }
                    }}
            }.onAppear(perform: getMenuData)
        }}
        
        func getMenuData() {
            PersistenceController.shared.clear()
            let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let fullMenu = try? JSONDecoder().decode(MenuList.self, from: data)
                    for menu in fullMenu!.menu {
                        if !Dish.exists(title: menu.title, viewContext)!{
                            let newMenuItem = Dish(context: viewContext)
                            newMenuItem.title = menu.title
                            newMenuItem.price = menu.price
                            newMenuItem.image = menu.image
                        }
                    }
                    
                    try? viewContext.save()
                }
                
            }
            task.resume()
        }
    }

#Preview {
    Menu().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
