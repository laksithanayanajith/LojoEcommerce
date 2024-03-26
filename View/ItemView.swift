//
//  ItemView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//

import SwiftUI

struct ItemView: View {
    let itemId: Int
    @State private var isLoading = true
    @State private var item: ItemElement?
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else if let item = item {
                Text("Item Name: \(item.name)")
                Text("Description: \(item.description)")
                Text("Price: $\(String(format: "%.2f", item.price))")
            }
        }
        .padding()
        .onAppear {
            Task {
                await fetchItem(byID: itemId) { fetchedItem in
                    self.item = fetchedItem
                    self.isLoading = false
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
