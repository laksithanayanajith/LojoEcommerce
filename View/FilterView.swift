//
//  FilterView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-21.
//

import SwiftUI
import URLImage

struct FilterView: View {
    @State private var isFilterPresented = false
        
        var body: some View {
            NavigationView {
                List {
                    Button("Price") {
                        // Handle price button action
                    }
                    Button("Category") {
                        // Handle category button action
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Filter")
                .navigationBarItems(trailing:
                    Button(action: {
                        isFilterPresented.toggle()
                    }) {
                        URLImage(URL(string: "https://img.icons8.com/ios/50/delete-sign--v1.png")!) { image in
                            image
                                .resizable()
                                .frame(width: 20, height: 20)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                )
            }
            .sheet(isPresented: $isFilterPresented) {
                // Your filter options UI goes here
                FilterOptionsView()
            }
        }
}

struct FilterOptionsView: View {
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
            .navigationTitle("Filter Options")
            .navigationBarItems(trailing:
                Button("Close") {
                    // Handle close action
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
