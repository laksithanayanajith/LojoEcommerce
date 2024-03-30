//
//  LoginView.swift
//  LojoEcommerce
//
//  Created by NIBM on 2024-03-30.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginClicked: Bool = false
    @State private var isUserLogged: Bool = false
    
    var body: some View {
        
        NavigationView{
            
            VStack(spacing: 20) {
                
                Spacer() // Pushes the text to the top
                                
                Text("LOJO")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .position(x: UIScreen.main.bounds.width / 2.1, y: UIScreen.main.bounds.height / 5)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(50)
                    .shadow(radius: 5)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(50)
                    .shadow(radius: 5)
                
                NavigationLink(destination: CartView(isUserLogged: $isUserLogged), isActive: $isLoginClicked) {
                    EmptyView()
                }
                .hidden()
                
                Button(action: {
                    isLoginClicked = true
                    isUserLogged = true
                }) {
                    Text("Login")
                        .padding(15)
                        .foregroundColor(.white)
                }
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.black, lineWidth: 0)
                )
                .background(.black)
                .cornerRadius(50)
                .padding(.horizontal, 50)
                
                HStack{
                    Text("New to the platform?").font(.footnote).foregroundColor(.gray)
                    
                    NavigationLink(destination: SignUpView()) {
                            Text("Create an account")
                            .font(.footnote)
                            .fontWeight(.medium)
                    }
                }
                .position(x: UIScreen.main.bounds.width / 2.2, y: UIScreen.main.bounds.height / 20)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onDisappear {
                    if isLoginClicked {
                        isUserLogged = true
                    }
                }
    }
}

#Preview {
    LoginView()
}
