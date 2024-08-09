//
//  ContentView.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    @State private var root: RootView = .Login
    
    var body: some View {
        NavigationStack {
            switch(root) {
            case .Login:
                SignInView(rootScreen: self.$root)
                    .environmentObject(fireAuthHelper)
            case .Home:
                HomeView(rootScreen: self.$root)
                    .environmentObject(fireAuthHelper)
                    .environmentObject(fireDBHelper)
            case .SignUp:
                SignUpView(rootScreen: self.$root)
                    .environmentObject(fireAuthHelper)
            case .Profile:
                ProfileView(rootScreen: self.$root)
                    .environmentObject(fireAuthHelper)
            }
        }
    }
}
