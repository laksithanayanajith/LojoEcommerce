//
//  CartView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-27.
//

import Foundation
import SwiftUI

struct CartView: View {
    
    @State private var selectedItems: [CartSelectedItemElement] = []

    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(selectedItems) { selectedItem in
                        CartItemView(selectedItem: selectedItem)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            Task {
                await fetchSelectedItems { sitems in
                    if let sitems = sitems {
                        selectedItems = sitems
                    }
                }
            }
        }
    }
}

struct CartItemView: View {
    
    var selectedItem: CartSelectedItemElement

    var body: some View {
        VStack {
            Text(selectedItem.selectedSize)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}


#Preview{
    CartView()
}
