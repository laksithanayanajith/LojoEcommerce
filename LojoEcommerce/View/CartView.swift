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
    @State private var subtotal: Double?
    
    var body: some View {
        
        VStack{
            
            HStack{
                Text("LOJO")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
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
                
                fetchSubTotal { fetchedSubtotal in
                                        subtotal = fetchedSubtotal
                                    }
            }
            
            if let subtotal = subtotal {
                
                Text("Total Amount")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                            Text("$\(subtotal)")
                                .foregroundColor(.black)
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                        }
            
            Button(action: {
            }) {
                Text("Checkout")
                    .padding(15)
                    .foregroundColor(.white)
            }
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.black, lineWidth: 0)
            )
            .background(.black)
            .cornerRadius(50)
            .padding()
        }
    }
}

struct CartItemView: View {
    
    @State var selectedItem: CartSelectedItemElement
    @State private var isShowSelectedItem: Bool = true
    @State var incrementQuantity: Int = 0
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        
        VStack(spacing: 10) {
            if isShowSelectedItem {
                VStack(spacing: 10) {
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 5) {
                            if let name = selectedItem.item?.name {
                                Text(name)
                                    .font(.headline)
                                    .fontWeight(.thin)
                                    .foregroundColor(.primary)
                            }
                            Text(selectedItem.selectedSize + "\n")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.orange)
                            
                            if let price = selectedItem.item?.price {
                                
                                if let currentQuantity = selectedItem.quantity {
                                    
                                    var totalPrice = price * Double(incrementQuantity == 0 ? currentQuantity : incrementQuantity + 1)
                                    
                                    Text("$\(totalPrice)")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            }
                        }
                        Spacer()
                        VStack(spacing: 5) {
                            Button(action: {
                                incrementQuantity = incrementQuantity + 1
                                
                                if let id = selectedItem.id,
                                   let quantity = selectedItem.quantity,
                                   let price = selectedItem.item?.price,
                                   let itemid = selectedItem.itemID {
                                    
                                    // Calculate the new total price based on the updated quantity
                                    let totalPrice = price * Double(incrementQuantity == 0 ? quantity : quantity + incrementQuantity + 1)

                                    // Create a new CartSelectedItemElement with the updated quantity and total price
                                    let updatedSelectedItem = SelectedItemElement(id: id, quantity: quantity + incrementQuantity, totalPrice: totalPrice, selectedSize: selectedItem.selectedSize, itemID: itemid)
                                    
                                    Task {
                                        await updateSelectedItem(id: id, selectedItem: updatedSelectedItem) { success in
                                            if success {
                                                print("Updated!")
                                            }
                                            else{
                                                print("Not updated!")
                                            }
                                        }
                                    }
                                }

                                
                            }) {
                                Text("+")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .shadow(radius: 3)
                            }
                            if let quantity = selectedItem.quantity {
                                Text("\(quantity + incrementQuantity)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            }
                            
                            
                            
                            Button(action: {
                                
                                incrementQuantity = incrementQuantity - 1

                                if incrementQuantity < 0 {
                                    incrementQuantity = 0
                                    showDeleteAlert = true
                                }
                                
                                if let id = selectedItem.id,
                                   let quantity = selectedItem.quantity,
                                   let price = selectedItem.item?.price,
                                   let itemid = selectedItem.itemID {
                                    
                                    // Calculate the new total price based on the updated quantity
                                    let totalPrice = price * Double(incrementQuantity == 0 ? quantity : quantity + incrementQuantity + 1)

                                    // Create a new CartSelectedItemElement with the updated quantity and total price
                                    let updatedSelectedItem = SelectedItemElement(id: id, quantity: quantity + incrementQuantity, totalPrice: totalPrice, selectedSize: selectedItem.selectedSize, itemID: itemid)
                                    
                                    Task {
                                        await updateSelectedItem(id: id, selectedItem: updatedSelectedItem) { success in
                                            if success {
                                                print("Updated!")
                                            }
                                            else{
                                                print("Not updated!")
                                            }
                                        }
                                    }
                                }

                                
                            }) {
                                Text("-")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .shadow(radius: 3)
                            }
                            .alert(isPresented: $showDeleteAlert) {
                                Alert(
                                    title: Text("Delete Item"),
                                    message: Text("Do you want to delete this jacket?"),
                                    primaryButton: .destructive(Text("Yes")) {
                                        if let id = selectedItem.id {
                                            Task {
                                                await deleteSelectedItem(id: id) { success in
                                                    if success {
                                                        print("Successfully deleted the item")
                                                        isShowSelectedItem = false
                                                    } else {
                                                        print("Failed to delete the item")
                                                    }
                                                }
                                            }
                                        } else {
                                            print("Error: selectedItem.id is nil")
                                        }
                                    },
                                    secondaryButton: .cancel(Text("No"))
                                )
                            }
                        }
                    }
                    HStack {
                        Button(action: {
                            if let id = selectedItem.id {
                                Task {
                                    await deleteSelectedItem(id: id) { success in
                                        if success {
                                            print("Successfully deleted the item")
                                            isShowSelectedItem = false
                                        } else {
                                            print("Failed to delete the item")
                                        }
                                    }
                                }
                            } else {
                                print("Error: selectedItem.id is nil")
                            }
                        }) {
                            Text("Delete")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundColor(.red)
                                .padding(5)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(20)
            }
        }
        .padding(.horizontal)
    }
}

#Preview{
    CartView()
}
