//
//  ContentView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-27.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tabSelection: Int = 1
    
    var body: some View {
        
        NavigationView{
            TabView(selection: $tabSelection){
                
                NavigationLink(destination: HomeView()){
                    HomeView().tag(1)
                }
                
                NavigationLink(destination: SearchView()){
                    SearchView().tag(2)
                }
                
                NavigationLink(destination: CartView()){
                    CartView().tag(3)
                }
            }
            
            .overlay(alignment: .bottom){
                CustomTabView(tabSelection: $tabSelection)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
