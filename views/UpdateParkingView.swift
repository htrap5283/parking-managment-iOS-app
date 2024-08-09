//
//  UpdateParkingView.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//


import SwiftUI
import CoreLocation

struct UpdateParkingView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @Environment(\.presentationMode) private var presentationMode
    
    @State var buildingCode: String
    @State var hours: String
    @State var licensePlate: String
    @State var hostSuite: String
    @State var streetName: String
    @State private var showErrorAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var parking: Parking
    
    init(parking: Parking) {
        _buildingCode = State(initialValue: parking.buildingCode)
        _hours = State(initialValue: parking.hours)
        _licensePlate = State(initialValue: parking.licensePlate)
        _hostSuite = State(initialValue: parking.hostSuite)
        _streetName = State(initialValue: parking.location)
        self.parking = parking
    }
    
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
                self.updateParking()
            }) {
                Text("Update Parking")
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
        .navigationTitle("Update Parking")
    }
    
    private func updateParking() {
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
                self.saveUpdatedParking(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, location: streetName)
            } else {
                self.alertMessage = "Unable to find location for the provided street name."
                self.showErrorAlert = true
            }
        }
    }
    
    private func saveUpdatedParking(latitude: Double, longitude: Double, location: String) {
        var updatedParking = parking
        updatedParking.buildingCode = buildingCode
        updatedParking.hours = hours
        updatedParking.licensePlate = licensePlate
        updatedParking.hostSuite = hostSuite
        updatedParking.location = location
        updatedParking.latitude = latitude
        updatedParking.longitude = longitude
        
        fireDBHelper.updateParkingRecord(recordToUpdate: updatedParking)
        self.presentationMode.wrappedValue.dismiss()
    }
}
