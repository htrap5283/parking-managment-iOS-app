//
//  ParkingMapView.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//


import SwiftUI
import MapKit

struct ParkingMapView: View {
    var parking: Parking
    
    var body: some View {
        VStack {
            MapView(location: CLLocationCoordinate2D(latitude: parking.latitude, longitude: parking.longitude))
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarTitle("Parking Location")
    }
}

struct MapView: UIViewRepresentable {
    var location: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        uiView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        uiView.setRegion(region, animated: true)
    }
}
