//
//  SignInView.swift
//  PARTH_PARKING
//
//  Created by Parth Panchal on 2024-07-09.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false
    @Binding var rootScreen: RootView
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    @State private var showSignUp : Bool = false
    
    private let gridItems : [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            Form {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .disableAutocorrection(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            
            LazyVGrid(columns: self.gridItems){
                Button(action: {
                    
                    if (!self.email.isEmpty && !self.password.isEmpty){
                        
                        self.fireAuthHelper.signIn(email: self.email, password: self.password)
                        
                        self.rootScreen = .Home
                        
                    }else{
                        print(#function, "email and password cannot be empty")
                    }
                }){
                    Text("Sign In")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .background(Color.blue)
                }
                
                Button(action: {
                    
                    
                    self.rootScreen = .SignUp
                }){
                    Text("Sign Up")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .background(Color.blue)
                }
            }
            
            Spacer()
        }
        .onAppear{
            self.fireAuthHelper.listenToAuthState()
        }
        .navigationDestination(isPresented: self.$showSignUp){
            SignUpView(rootScreen: self.$rootScreen)
                .environmentObject(self.fireAuthHelper)
        }
        
        
    }
    
}


