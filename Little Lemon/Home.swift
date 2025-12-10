//
//  Home.swift
//  Little Lemon
//
//  Created by Stephen Sneed on 11/20/25.
//

import SwiftUI
import CoreData

struct Home: View {
    let persistence = PersistenceController.shared

    var body: some View {
        ZStack {
            LittleLemonLogo().padding(10).frame(maxWidth: .infinity, alignment: .center)
            //NavigationLink(destination: UserProfile()) {
            Image("profile-image-placeholder").resizable().scaledToFit().clipShape(Circle()).frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 15)
            //}
        }.frame(maxWidth: .infinity, maxHeight: 60)
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
