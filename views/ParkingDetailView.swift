//
//  ParkingDetailView.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//

import SwiftUI
import MapKit

struct ParkingDetailView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @State private var showUpdateView: Bool = false
    let parking: Parking
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Building Code: \(parking.buildingCode)")
            Text("Hours: \(parking.hours)")
            Text("License Plate: \(parking.licensePlate)")
            Text("Host Suite: \(parking.hostSuite)")
            Text("Location: \(parking.location)")
            Text("Date & Time: \(parking.dateTime)")
            
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: parking.latitude, longitude: parking.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )))
            .frame(height: 200)
            
            Spacer()
            
            Button(action: {
                showUpdateView.toggle()
            }) {
                Text("Update Parking")
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $showUpdateView) {
                UpdateParkingView(parking: parking)
                    .environmentObject(fireDBHelper)
            }
        }
        .padding()
        .navigationTitle("Parking Details")
    }
}
