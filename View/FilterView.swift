//
//  FilterView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-21.
//

import SwiftUI

struct FilterView: View {
    
    @State private var isFilterPresented = false
        
    var body: some View {
        FilterOptionsView()
    }
}

struct FilterOptionsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Price")) {
                    Button("< $155.00") {
                        // Handle price option action
                    }
                    Button("$155.00 - $160.00") {
                        // Handle price option action
                    }
                    Button("$161.00 - $185.00") {
                        // Handle price option action
                    }
                    Button("> $190.00") {
                        // Handle price option action
                    }
                }
                Section(header: Text("Category")) {
                    Button("Leather") {
                        // Handle category option action
                    }
                    Button("Denim") {
                        // Handle category option action
                    }
                    Button("Peacoats") {
                        // Handle category option action
                    }
                    Button("Sports") {
                        // Handle category option action
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Filter Jackets")
            .navigationBarItems(trailing:
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
