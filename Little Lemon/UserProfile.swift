//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Stephen Sneed on 11/20/25.
//

import SwiftUI

struct UserProfile: View {
    let firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? ""
    let lastName: String = UserDefaults.standard.string(forKey: "lastName") ?? ""
    let email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text("\(firstName)")
            Text("\(lastName)")
            Text("\(email)")
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
