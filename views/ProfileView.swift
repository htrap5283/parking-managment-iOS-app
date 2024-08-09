//
//  ProfileView.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//
//
//
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    @Binding var rootScreen: RootView
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showUpdateProfile = false
    
    var body: some View {
        VStack {
            Text("Profile Information")
                .font(.title)
            
            if let user = fireAuthHelper.user {
                Text("Name: \(user.name)")
                Text("Email: \(user.email)")
                Text("Contact Number: \(user.contactNumber)")
                
                VStack(alignment: .leading) {
                    Text("Car Plates:")
                    ForEach(user.carPlates, id: \.self) { plate in
                        Text(plate)
                    }
                }
            } else {
                Text("No user logged in.")
            }
            
            Button(action: signOut) {
                Text("Sign Out")
            }
            .padding()
            
            Button(action: deleteAccount) {
                Text("Delete Account")
                    .foregroundColor(.red)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Update") {
                    showUpdateProfile = true
                }
            }
        }
        .sheet(isPresented: $showUpdateProfile) {
            UpdateProfileView()
                .environmentObject(fireAuthHelper)
        }
    }
    
    private func signOut() {
        fireAuthHelper.signOut()
        self.rootScreen = .Login
        presentationMode.wrappedValue.dismiss()
    }
    
    private func deleteAccount() {
        fireAuthHelper.deleteUser()
        self.rootScreen = .Login
        presentationMode.wrappedValue.dismiss()
    }
}

