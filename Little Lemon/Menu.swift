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
    @ObservedObject var menuModel = MenuModel()
    @State var searchText = ""
    @State var searchCategory = "All"

    var body: some View {
        VStack {
            VStack {
                ZStack {
                    VStack (alignment: .leading){
                        Text("Little Lemon").font(.custom(
                            "Palatino-Bold",
                            fixedSize: 48)).foregroundStyle(Color.primaryYellow).padding(.vertical, 0).padding(.horizontal, 15).padding(.top, 10)
                        Text("Chicago").font(.custom(
                            "Palatino-Bold",
                            fixedSize: 32)).foregroundStyle(Color.secondaryWhite).padding(.vertical, 0).padding(.horizontal, 15)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.").fixedSize(horizontal: false, vertical: true).font(.custom(
                            "SanFranciscoText-Regular",
                            fixedSize: 20)).foregroundStyle(Color.secondaryWhite).frame(width: 250, alignment: .leading).padding(.top, 10).padding(.bottom, 15).padding(.horizontal, 15)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image("restaurant").resizable().clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous)).frame(width: 150, height: 150).frame(maxWidth: .infinity, alignment: .trailing).padding().padding(.top, 50)
                }
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondaryWhite)
                        .padding(.leading, 10)
                    
                    TextField("Search menu", text: $searchText)
                        .padding(.vertical, 10)
                        .padding(.trailing, 10)
                        .padding(.leading, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(Color.secondaryWhite))
                        ).foregroundColor(Color.secondaryBlack)
                        .overlay(
                            HStack {
                                Spacer()
                                if !searchText.isEmpty {
                                    Button(action: {
                                        searchText = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.secondaryBlack)
                                            .padding(.trailing, 10)
                                    }
                                }
                            }
                        )
                }
                .padding(.bottom, 10)
                .padding(.trailing, 15)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primaryGreen)
            
            Text("ORDER FOR DELIVERY!").font(.custom(
                "Helvetica-Bold",
                fixedSize: 20)).foregroundStyle(Color.secondaryBlack).frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 5).padding(.horizontal, 15)
            HStack {
                CategoryButton(category: "Starters", searchCategory: $searchCategory)
                Spacer()
                CategoryButton(category: "Mains", searchCategory: $searchCategory)
                Spacer()
                CategoryButton(category: "Desserts", searchCategory: $searchCategory)
                Spacer()
                CategoryButton(category: "Drinks", searchCategory: $searchCategory)
            }.padding(.horizontal, 15).padding(.bottom, 5)
            Divider()

            NavigationStack {
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List {
                            ForEach(dishes, id:\.self) { dish in
                                NavigationLink (destination: DisplayDish(dish)){
                                    HStack {
                                        VStack (alignment: .leading){
                                            Text("\(dish.title ?? "")").font(.custom(
                                                "SanFranciscoText-Regular",
                                                fixedSize: 18))
                                            Text("\(dish.details ?? "")").font(.custom(
                                                "SanFranciscoText-Regular",
                                                fixedSize: 16)).frame(width: 250, height: 30, alignment: .leading)
                                            Text("$\(dish.price ?? "0.00")").font(.custom(
                                                "SanFranciscoText-Regular",
                                                fixedSize: 18))
                                        }
                                        Spacer()
                                        Image(dish.image ?? "").resizable().frame(width: 50, height: 50).frame(maxWidth: .infinity, alignment: .trailing)
                                        /*
                                         AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                         image.resizable()
                                         } placeholder: {
                                         ProgressView()
                                         }
                                         .frame(width: 50, height: 50).frame(maxWidth: .infinity, alignment: .trailing)
                                         */
                                    }
                                }
                            }
                        }
                    }.task {
                        menuModel.reload(viewContext)
                    }

            }
        }}
    
    /*
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
     */

    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty && searchCategory == "All" {
            return NSPredicate(value: true)
        } else if searchText.isEmpty {
            return NSPredicate(format: "category CONTAINS[cd] %@", searchCategory.lowercased())
        } else if searchCategory == "All" {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@ && category CONTAINS[cd] %@", searchText, searchCategory.lowercased())

        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return   [NSSortDescriptor(key: "title",
                                   ascending: true,
                                   selector: #selector(NSString.localizedStandardCompare))]
    }
}

struct CategoryButton: View {
    let category: String
    @Binding var searchCategory: String
    var body: some View {
        Button(action: {
            if searchCategory == category {
                searchCategory = "All"
            } else {
                searchCategory = category
            }
        }) {
            Text(category)
        }.padding().foregroundStyle(Color.secondaryBlack).background(category == searchCategory ? Color.primaryYellow : Color.secondaryWhite).clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    Menu().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
