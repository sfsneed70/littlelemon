//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Stephen Sneed on 11/20/25.
//

import SwiftUI

struct UserProfile: View {
    @State var firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? ""
    @State var lastName: String = UserDefaults.standard.string(forKey: "lastName") ?? ""
    @State var email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    @Environment(\.presentationMode) var presentation
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            VStack (alignment: .leading){
                Text("Personal Information").font(.custom(
                    "SanFranciscoText-Bold",
                    fixedSize: 20)).padding()
                Text("Avatar").font(.custom(
                    "SanFranciscoText",
                    fixedSize: 16)).padding(.horizontal)
                HStack {
                    Image("profile-image-placeholder").clipShape(Circle()).padding(.horizontal)
                    Spacer()
                    Button("Update") {
                    }.padding().foregroundStyle(Color.secondaryBlack).background(Color.primaryYellow).clipShape(RoundedRectangle(cornerRadius: 20))
                    Spacer()
                    Button("Remove") {
                    }.padding().foregroundStyle(Color.secondaryBlack).background(Color.secondaryWhite).clipShape(RoundedRectangle(cornerRadius: 20)).frame(maxWidth: .infinity, alignment: .center)
                }
                Text("First Name").padding(.horizontal).padding(.top, 10).font(.custom(
                    "SanFranciscoText-Regular",
                    fixedSize: 16))
                TextField("", text: $firstName).keyboardType(.default).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1)).textFieldStyle(.roundedBorder).padding(.horizontal)
                Text("Last Name").padding(.horizontal).padding(.top, 10).font(.custom(
                    "SanFranciscoText-Regular",
                    fixedSize: 16))
                TextField("", text: $lastName).keyboardType(.default).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1)).textFieldStyle(.roundedBorder).padding(.horizontal)
                Text("Email").padding(.horizontal).padding(.top, 10).font(.custom(
                    "SanFranciscoText-Regular",
                    fixedSize: 16))
                TextField("", text: $email).keyboardType(.emailAddress).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1)).textFieldStyle(.roundedBorder).padding(.horizontal)
                HStack {
                    Button("Save changes") {
                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && isValidEmail(email) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        } else {
                            showAlert = true
                        }
                    }.padding().foregroundStyle(Color.secondaryBlack).background(Color.primaryYellow).clipShape(RoundedRectangle(cornerRadius: 20)).padding().alert(isPresented: $showAlert) {
                        Alert(title: Text("Must enter First Name, Last Name, and a valid Email"))
                    }
                    Spacer()

                    Button("Discard changes") {
                        reloadProfile()
                    }.padding().foregroundStyle(Color.secondaryBlack).background(Color.secondaryWhite).clipShape(RoundedRectangle(cornerRadius: 20)).padding()
                }
                Button("Logout") {
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    self.presentation.wrappedValue.dismiss()
                }.padding().foregroundStyle(Color.secondaryBlack).background(Color.primaryYellow).clipShape(RoundedRectangle(cornerRadius: 20)).frame(maxWidth: .infinity, alignment: .center).padding(.top, 20)
            }.onAppear(perform: reloadProfile)
        }
    }
    
    func reloadProfile() {
        firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
        lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
        email = UserDefaults.standard.string(forKey: "email") ?? ""
    }
}


#Preview {
    UserProfile()
}
