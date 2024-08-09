//
//  NewParkingRecord.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//

import SwiftUI
import CoreLocation

struct NewParkingView: View {
    
    @State private var buildingCode: String = ""
    @State private var hours: String = "1-hour"
    @State private var licensePlate: String = ""
    @State private var hostSuite: String = ""
    @State private var streetName: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    var body: some View {
        VStack {
            Form {
                TextField("Building Code", text: self.$buildingCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Picker(selection: self.$hours, label: Text("Hours")) {
                    Text("1-hour").tag("1-hour")
                    Text("4-hour").tag("4-hour")
                    Text("12-hour").tag("12-hour")
                    Text("24-hour").tag("24-hour")
                }
                
                TextField("License Plate", text: self.$licensePlate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                TextField("Host Suite", text: self.$hostSuite)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                TextField("Street Name", text: self.$streetName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
            }
            
            Button(action: {
                self.addNewParking()
            }) {
                Text("Add Parking")
            }
            .alert(isPresented: self.$showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(self.alertMessage),
                    dismissButton: .default(Text("Try Again"))
                )
            }
            Spacer()
        }
        .onDisappear {
            
            self.buildingCode = ""
            self.hours = "1-hour"
            self.licensePlate = ""
            self.hostSuite = ""
            self.streetName = ""
        }
        .navigationTitle("New Parking")
    }
    
    private func addNewParking() {
        guard !buildingCode.isEmpty, buildingCode.count == 5,
              !licensePlate.isEmpty, licensePlate.count >= 2 && licensePlate.count <= 8,
              !hostSuite.isEmpty, hostSuite.count >= 2 && hostSuite.count <= 5,
              !streetName.isEmpty else {
            self.alertMessage = "Please fill out all fields correctly."
            self.showErrorAlert = true
            return
        }
        
        geocodeStreetName(streetName)
    }
    
    private func geocodeStreetName(_ streetName: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(streetName) { placemarks, error in
            if let error = error {
                self.alertMessage = "Error in geocoding: \(error.localizedDescription)"
                self.showErrorAlert = true
                return
            }
            
            if let placemark = placemarks?.first,
               let location = placemark.location {
                self.saveParking(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, location: streetName)
            } else {
                self.alertMessage = "Unable to find location for the provided street name."
                self.showErrorAlert = true
            }
        }
    }
    
    private func saveParking(latitude: Double, longitude: Double, location: String) {
        let newParking = Parking(
            buildingCode: buildingCode,
            hours: hours,
            licensePlate: licensePlate,
            hostSuite: hostSuite,
            location: location,
            latitude: latitude,
            longitude: longitude,
            dateTime: Date()
        )
        
        fireDBHelper.insertParkingRecord(newRecord: newParking)
        self.presentationMode.wrappedValue.dismiss()
    }
}
