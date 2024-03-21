//
//  FilterView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-21.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var items: [ItemElement]
    var onFilterApplied: (([ItemElement]) -> Void)
        
    var body: some View {
        FilterOptionsView(items: $items, onFilterApplied: onFilterApplied)
    }
}

struct FilterOptionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var items: [ItemElement]
    var onFilterApplied: (([ItemElement]) -> Void)
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Price")) {
                    Button("< $155.00") {
                        let filteredItems = items.filter { $0.price < 155.00 }
                        self.items = filteredItems
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("$155.00 - $160.00") {
                        let filteredItems = items.filter { $0.price >= 155.00 && $0.price <= 160.00 }
                        self.items = filteredItems
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("$161.00 - $185.00") {
                        let filteredItems = items.filter { $0.price >= 161.00 && $0.price <= 185.00 }
                        self.items = filteredItems
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("> $190.00") {
                        let filteredItems = items.filter { $0.price > 190.00 }
                        self.items = filteredItems
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                Section(header: Text("Category")) {
                    Button("Leather") {
                        let filteredItems = items.filter { $0.category == "Leather" }
                        self.items = filteredItems
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("Denim") {
                        let filteredItems = items.filter { $0.category == "Denim" }
                        self.items = filteredItems
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("Peacoats") {
                        let filteredItems = items.filter { $0.category == "Peacoats" }
                        self.items = filteredItems
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("Sports") {
                        let filteredItems = items.filter { $0.category == "Sports" }
                        self.items = filteredItems
                        presentationMode.wrappedValue.dismiss()
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
    
    struct FilterView_Previews: PreviewProvider {
        static var previews: some View {
            let items: [ItemElement] = []
            FilterView(items: .constant(items)) { filteredItems in filteredItems }
        }
    }

}
