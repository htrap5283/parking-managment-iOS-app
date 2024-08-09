//
//  FireAuthHelper.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.

import SwiftUI
import Firebase


class FireAuthHelper: ObservableObject {
    
    
    @Published var user: User? {
        didSet {
            objectWillChange.send()
        }
    }
    
    private static var shared: FireAuthHelper?
    
    static func getInstance() -> FireAuthHelper {
        if shared == nil {
            shared = FireAuthHelper()
        }
        return shared!
    }
    
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if let self = self {
                if let user = user {
                    self.fetchUserData()
                } else {
                    self.user = nil
                }
                
                print(#function, "Auth state changed: \(user?.email ?? "No user")")
            }
        }
    }
    
    
    func signUp(name: String, email: String, password: String, confirmPassword: String, contactNumber: String, carPlates: [String]) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error creating user: \(error)")
                return
            }
            
            guard let user = result?.user else {
                print("User creation failed")
                return
            }
            
            let newUser = User(name: name, email: email, contactNumber: contactNumber, carPlates: carPlates, password: password, confirmPassword: confirmPassword)
            let db = Firestore.firestore()
            do {
                try db.collection("users").document(user.uid).setData(from: newUser)
            } catch let error {
                print("Error saving user data: \(error)")
            }
        }
    }
    
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
            } else {
                print("User signed in successfully")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
            
        } catch let error {
            print(#function, "Unable to sign out user : \(error)")
        }
    }
    
    func updateUserProfile(name: String, contactNumber: String, carPlates: [String]) {
        if let userId = Auth.auth().currentUser?.uid {
            let userRef = Firestore.firestore().collection("users").document(userId)
            
            
            let userData: [String: Any] = [
                "name": name,
                "contactNumber": contactNumber,
                "carPlates": carPlates
            ]
            
            userRef.setData(userData, merge: true) { error in
                if let error = error {
                    print("Error updating user profile: \(error)")
                } else {
                    self.fetchUserData()
                }
            }
        }
    }
    
    
    func deleteUser() {
        if let userId = Auth.auth().currentUser?.uid {
            let userRef = Firestore.firestore().collection("users").document(userId)
            
            userRef.delete { error in
                if let error = error {
                    print("Error deleting user document: \(error)")
                } else {
                    Auth.auth().currentUser?.delete { error in
                        if let error = error {
                            print("Error deleting user account: \(error)")
                        } else {
                            self.user = nil
                        }
                    }
                }
            }
        }
    }
    
    
    private func fetchUserData() {
        if let userId = Auth.auth().currentUser?.uid {
            let userRef = Firestore.firestore().collection("users").document(userId)
            
            userRef.getDocument { document, error in
                if let document = document, document.exists {
                    do {
                        self.user = try document.data(as: User.self)
                    } catch {
                        print("Error decoding user data: \(error.localizedDescription)")
                        self.user = nil
                    }
                } else {
                    print("User document does not exist")
                    self.user = nil
                }
            }
        }
    }
    
    
    
    
}
