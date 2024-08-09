//
//  User.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var password: String
    var confirmPassword: String
    var contactNumber: String
    var carPlates: [String]
    
    init(name: String, email: String, contactNumber: String, carPlates: [String], password: String, confirmPassword: String) {
        self.name = name
        self.email = email
        self.contactNumber = contactNumber
        self.carPlates = carPlates
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
