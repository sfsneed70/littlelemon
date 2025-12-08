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
    @State var searchText = ""

    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("Online Restaurant Application")
            NavigationStack {
                TextField("Search menu", text: $searchText)
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                    (dishes: [Dish]) in
                        List {
                            ForEach(dishes, id:\.self) { dish in
                                NavigationLink (destination: DisplayDish(dish)){
                                    HStack {
                                        Text("\(dish.title ?? "") - $\(dish.price ?? "0.00")")
                                        AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 50, height: 50)
                                    }
                                }
                            }
                        }
                }.onAppear(perform: getMenuData)
            }
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
                        newMenuItem.category = menu.category
                        newMenuItem.details = menu.description
                    }
                }
                
                try? viewContext.save()
            }
            
        }
        task.resume()
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return   [NSSortDescriptor(key: "title",
                                   ascending: true,
                                   selector: #selector(NSString.localizedStandardCompare))]
    }
}

#Preview {
    Menu().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
