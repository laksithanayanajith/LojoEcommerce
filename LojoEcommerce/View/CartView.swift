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
    @State private var isShowSelectedItem: Bool = true

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
                                .frame(width: 150)
                                .padding(.horizontal)
                        }
                        
                        Text("\(selectedItem.selectedSize)\n")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .frame(width: 100)
                            .padding(.horizontal)
                    }
                    
                    VStack{
                        Button(action: {
                            
                        }) {
                            Text("+")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(5)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                        
                        if let quantity = selectedItem.quantity {
                            Text("\(quantity)")
                                .font(.footnote)
                                .fontWeight(.medium)
                        }
                        
                        Button(action: {
                            
                        }) {
                            Text("-")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(5)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                    }
                }
                
                HStack{
                    
                    if let price = selectedItem.item?.price {
                        Text("\(price)")
                            .font(.headline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .alignmentGuide(.leading) { _ in -15 }
                    }
                }
                
                Button(action: {
                    Task{
                        if let id = selectedItem.id {
                            await deleteSelectedItem(id: id) { success in
                                if success {
                                    print("Successfully deleted the item")
                                } else {
                                    // Handle deletion failure if needed
                                    print("Failed to delete the item")
                                }
                            }
                        } else {
                            print("Error: selectedItem.id is nil")
                            // Handle the case when selectedItem.id is nil
                        }
                        
                    }
                }) {
                    Text("delete")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .padding(5)
                }

            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 200)
    }
}


#Preview{
    CartView()
}
