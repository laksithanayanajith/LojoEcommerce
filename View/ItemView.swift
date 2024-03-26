//
//  ItemView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//

import SwiftUI

struct ItemView: View {
    let itemId: Int
    @State private var item: ItemElement?
    
    var body: some View {
        if let item = item {
            VStack {
                // Display item details here
                Text("Item Name: \(item.name)")
                Text("Description: \(item.description)")
                Text("Price: $\(String(format: "%.2f", item.price))")
            }
            .padding()
            .navigationBarTitle("Item Details", displayMode: .inline)
        } else {
            ProgressView()
                .onAppear {
                    Task{
                        await fetchItem(byID: itemId) { fetchedItem in
                            self.item = fetchedItem
                        }
                    }
                }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemView(itemId: 1)
        }
    }
}
