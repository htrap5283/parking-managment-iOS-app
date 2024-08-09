//
//  UpdateProfileView.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//

import SwiftUI

struct UpdateProfileView: View {
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    
    @State private var newName: String = ""
    @State private var newContactNumber: String = ""
    @State private var newCarPlates: [String] = [""]
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Update Profile")) {
                    TextField("New Name", text: $newName)
                        .autocapitalization(.words)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("New Contact Number", text: $newContactNumber)
                        .keyboardType(.phonePad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    ForEach($newCarPlates.indices, id: \.self) { index in
                        TextField("New Car Plate Number", text: $newCarPlates[index])
                            .autocapitalization(.allCharacters)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Button(action: updateProfile) {
                        Text("Update Profile")
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .padding()
        }
        .onAppear {
            if let user = fireAuthHelper.user {
                newName = user.name
                newContactNumber = user.contactNumber
                newCarPlates = user.carPlates
            }
        }
    }
    
    private func updateProfile() {
        fireAuthHelper.updateUserProfile(name: newName, contactNumber: newContactNumber, carPlates: newCarPlates)
        dismiss()
    }
}

