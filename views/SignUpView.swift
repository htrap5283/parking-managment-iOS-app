//
//  SignUpView.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//
//


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var contactNumber: String = ""
    @State private var carPlates: [String] = [""]
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false
    
    @Binding var rootScreen: RootView
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $name)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter Password Again", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Contact Number", text: $contactNumber)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                ForEach($carPlates.indices, id: \.self) { index in
                    TextField("Car Plate Number", text: $carPlates[index])
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: {
                    carPlates.append("")
                }) {
                    Text("Add Another Car Plate")
                }
            }
            .disableAutocorrection(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            
            Section {
                Button(action: {
                    // Validate the data
                    if validateFields() {
                        signUp()
                        self.rootScreen = .Home
                    }
                }) {
                    Text("Create Account")
                }
                .disabled(password != confirmPassword || email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
            }
        }
    }
    
    private func validateFields() -> Bool {
        if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || contactNumber.isEmpty || carPlates.isEmpty {
            errorMessage = "All fields are required"
            showAlert = true
            return false
        }
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            showAlert = true
            return false
        }
        
        return true
    }
    
    private func signUp() {
        fireAuthHelper.signUp(name: name, email: email, password: password, confirmPassword: confirmPassword, contactNumber: contactNumber, carPlates: carPlates)
    }
}

