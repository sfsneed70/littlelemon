//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Stephen Sneed on 11/20/25.
//

import SwiftUI

let kFirstName = "firstName"
let kLastName = "lastName"
let kEmail = "email"
let kIsLoggedIn = "isLoggedIn"

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && isValidEmail(email) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    }
                }
            }.onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
}


func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
    let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}


#Preview {
    Onboarding()
}
