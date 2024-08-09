//
//  FireDBHelper.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class FireDBHelper: ObservableObject {
    
    @Published var parkingList = [Parking]()
    
    private static var shared: FireDBHelper?
    private let db: Firestore
    
    private let COLLECTION_NAME = "ParkingRecords"
    private let FIELD_BUILDING_CODE = "buildingCode"
    private let FIELD_HOURS = "hours"
    private let FIELD_CAR_PLATE_NUMBER = "carPlateNumber"
    private let FIELD_HOST_SUITE_NUMBER = "hostSuiteNumber"
    private let FIELD_PARKING_LOCATION = "parkingLocation"
    private let FIELD_LATITUDE = "latitude"
    private let FIELD_LONGITUDE = "longitude"
    private let FIELD_DATE_TIME = "dateTime"
    private let FIELD_USER_ID = "userId"
    
    init() {
        self.db = Firestore.firestore()
    }
    
    static func getInstance() -> FireDBHelper {
        if shared == nil {
            shared = FireDBHelper()
        }
        return shared!
    }
    
    func insertParkingRecord(newRecord: Parking) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No logged in user")
            return
        }
        
        var data = try? Firestore.Encoder().encode(newRecord)
        data?[FIELD_USER_ID] = userId
        data?[FIELD_LATITUDE] = newRecord.latitude
        data?[FIELD_LONGITUDE] = newRecord.longitude
        
        self.db.collection(COLLECTION_NAME)
            .addDocument(data: data ?? [:]) { error in
                if let error = error {
                    print("Error inserting document to Firestore: \(error)")
                } else {
                    self.parkingList.append(newRecord)
                }
            }
    }
    
    func getAllParkingRecords() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No logged in user")
            return
        }
        
        self.db.collection(COLLECTION_NAME)
            .whereField(FIELD_USER_ID, isEqualTo: userId)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error)")
                    return
                }
                
                guard let snapshot = querySnapshot else {
                    print("No documents fetched")
                    return
                }
                
                self.parkingList = snapshot.documents.compactMap { document in
                    try? document.data(as: Parking.self)
                }.filter { $0.userId == userId }
            }
    }
    
    func updateParkingRecord(recordToUpdate: Parking) {
        guard let recordId = recordToUpdate.id else {
            print("Invalid parking record ID")
            return
        }
        
        do {
            try self.db.collection(COLLECTION_NAME)
                .document(recordId)
                .setData(from: recordToUpdate, merge: true)
        } catch {
            print("Error updating document in Firestore: \(error)")
        }
    }
    
    func deleteParkingRecord(recordToDelete: Parking) {
        guard let recordId = recordToDelete.id else {
            print("Invalid parking record ID")
            return
        }
        
        self.db.collection(COLLECTION_NAME)
            .document(recordId)
            .delete { error in
                if let error = error {
                    print("Error deleting document: \(error)")
                } else {
                    self.parkingList.removeAll { $0.id == recordId }
                }
            }
    }
}

