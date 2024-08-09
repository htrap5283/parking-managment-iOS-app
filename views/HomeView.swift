//
//  ViewParkiing.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @Binding var rootScreen: RootView
    @State private var showNewParkingView = false
    @State private var selectedParking: Parking?
    @State private var showProfileView = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                if fireDBHelper.parkingList.isEmpty {
                    VStack {
                        Text("No parking records found. Add a new record.")
                        Button(action: {
                            showNewParkingView = true
                        }) {
                            Text("Add Parking")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                } else {
                    List {
                        ForEach(fireDBHelper.parkingList) { parking in
                            NavigationLink(destination: ParkingDetailView(parking: parking)) {
                                VStack(alignment: .leading) {
                                    Text(parking.buildingCode)
                                        .fontWeight(.bold)
                                    Text(parking.licensePlate)
                                }
                                .onTapGesture {
                                    selectedParking = parking
                                }
                            }
                        }
                        .onDelete(perform: deleteParking)
                    }
                }
                
                Button(action: {
                    showNewParkingView = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.green)
                }
                .sheet(isPresented: $showNewParkingView) {
                    NewParkingView().environmentObject(fireDBHelper)
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView(rootScreen: $rootScreen).environmentObject(fireAuthHelper)) {
                        Text("Profile")
                    }
                }
            }
            .onAppear {
                fireDBHelper.getAllParkingRecords()
            }
        }
    }
    
    private func deleteParking(at offsets: IndexSet) {
        for index in offsets {
            let parking = fireDBHelper.parkingList[index]
            fireDBHelper.deleteParkingRecord(recordToDelete: parking)
        }
    }
}
