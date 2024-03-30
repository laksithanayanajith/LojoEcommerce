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
                
                HomeView()
                    .tabItem {
                            Text("Home")
                        }
                    .tag(1)
                                
                SearchView()
                    .tabItem {
                            Text("Search")
                        }
                    .tag(2)
                                
                CartView(isUserLogged: .constant(false))
                    .tabItem {
                            Text("Cart")
                        }
                    .tag(3)
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
