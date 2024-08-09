//
//  Parking.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//

import Foundation
import FirebaseFirestoreSwift

struct Parking: Codable, Identifiable, Hashable {
   
    
    @DocumentID var id: String?
    var buildingCode: String
    var hours: String
    var licensePlate: String
    var hostSuite: String
    var location: String 
    var latitude: Double
    var longitude: Double
    var dateTime: Date
    var userId: String?
    
    init( buildingCode: String, hours: String, licensePlate: String, hostSuite: String, location: String, latitude: Double, longitude: Double, dateTime: Date, userId: String? = nil) {
        
        self.buildingCode = buildingCode
        self.hours = hours
        self.licensePlate = licensePlate
        self.hostSuite = hostSuite
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.dateTime = dateTime
        self.userId = userId
    }
}
