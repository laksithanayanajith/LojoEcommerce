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
            VStack{
                HStack{
                    VStack{
                        if let name = selectedItem.item?.name {
                            Text("\(name)\n")
                                .font(.footnote)
                                .fontWeight(.thin)
                                .frame(width: 100)
                                .padding(.horizontal)
                        }
                        
                        Text("\(selectedItem.selectedSize)\n")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .frame(width: 200)
                            .padding(.horizontal)
                    }
                    
                    VStack{
                        Button(action: {
                            
                        }) {
                            Text("+")
                                .fontWeight(.bold) // Corrected fontWeight value
                                .foregroundColor(.black)
                                .border(Color.black) // You can directly use Color.black here
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 25) // Adjusted cornerRadius to half of frame width/height
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .frame(width: 50, height: 50)
                        .cornerRadius(25) // Set cornerRadius to half of frame width/height
                        
                        if let quantity = selectedItem.quantity {
                            Text("\(quantity)")
                                .font(.footnote)
                                .fontWeight(.medium)
                        }
                    }
                }
                .frame(width: .infinity)
                
                HStack{
                    
                    if let price = selectedItem.item?.price {
                        Text("\(price)")
                            .font(.headline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}


#Preview{
    CartView()
}
