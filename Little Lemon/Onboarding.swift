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
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                ZStack {
                    LittleLemonLogo().padding(10).frame(maxWidth: .infinity, alignment: .center)
                }.frame(maxWidth: .infinity, maxHeight: 60)
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
                    
                    Image("bruschetta").resizable().clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous)).frame(width: 150, height: 150).frame(maxWidth: .infinity, alignment: .trailing).padding().padding(.top, 50)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primaryGreen)
                
                VStack (alignment: .leading){
                    Text("First Name *").padding(.horizontal).padding(.top, 10).font(.custom(
                        "SanFranciscoText-Regular",
                        fixedSize: 20))
                    TextField("", text: $firstName).keyboardType(.default).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1)).textFieldStyle(.roundedBorder).padding(.horizontal)
                    Text("Last Name *").padding(.horizontal).padding(.top, 10).font(.custom(
                        "SanFranciscoText-Regular",
                        fixedSize: 20))
                    TextField("", text: $lastName).keyboardType(.default).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1)).textFieldStyle(.roundedBorder).padding(.horizontal)
                    Text("Email *").padding(.horizontal).padding(.top, 10).font(.custom(
                        "SanFranciscoText-Regular",
                        fixedSize: 20))
                    TextField("", text: $email).keyboardType(.emailAddress).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1)).textFieldStyle(.roundedBorder).padding(.horizontal)
                    Spacer()
                    Button("Register") {
                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && isValidEmail(email) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            firstName = ""
                            lastName = ""
                            email = ""
                            isLoggedIn = true
                        } else {
                            showAlert = true
                        }
                    }.padding().foregroundStyle(Color.secondaryBlack).background(Color.primaryYellow).clipShape(RoundedRectangle(cornerRadius: 20)).frame(maxWidth: .infinity, alignment: .center).alert(isPresented: $showAlert) {
                        Alert(title: Text("Must enter First Name, Last Name, and a valid Email"))
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
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
