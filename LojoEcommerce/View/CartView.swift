//
//  CartView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-27.
//

import Foundation
import SwiftUI
import URLImage

struct CartView: View {
    
    @State private var selectedItems: [CartSelectedItemElement] = []
    @State private var subtotal: Double?
    @State private var totalPrices: [Double] = []
    @State private var navigateToLoginView = false
    @Binding var isUserLogged: Bool
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                if totalPrices.reduce(0, +) > 0.00 {
                    HStack{
                        Text("LOJO")
                            .foregroundColor(.black)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                
                if totalPrices.reduce(0, +) <= 0.00 {
                    VStack {
                        
                        URLImage(URL(string: "https://cdn-icons-png.flaticon.com/512/4555/4555971.png")!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                        }
                        .cornerRadius(8)
                        .opacity(0.2)
                        
                        Text("\nYour cart is Empty!")
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .opacity(0.8)
                            .padding(.horizontal)
                        
                        Text("Discover new styles and accessories to elevate your wardrobe!")
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.center)
                            .opacity(0.8)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                }

                ZStack {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(selectedItems) { selectedItem in
                                if !totalPrices.isEmpty{
                                    CartItemView(selectedItem: selectedItem, totalPrices: $totalPrices)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                    Task {
                        await fetchSelectedItems { sitems in
                            if let sitems = sitems {
                                selectedItems = sitems
                            }
                        }
                    }
                }
                .onAppear {
                    Task {
                        await fetchSelectedItems { sitems in
                            if let sitems = sitems {
                                selectedItems = sitems
                                updateTotalPrices()
                            }
                        }
                    }
                }
                    
                if totalPrices.reduce(0, +) > 0.00 {
                    Text("Total Amount")
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                    Text("$\(String(format: "%.2f", totalPrices.reduce(0, +)))")
                        .foregroundColor(.black)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                    if totalPrices.reduce(0, +) > 0.00 {
                        NavigationLink(destination: LoginView(), isActive: $navigateToLoginView) {
                            EmptyView()
                        }
                        .hidden()
                    }
                
                    NavigationLink(destination: LoginView()){
                        Button(action: {
                            navigateToLoginView = true
                        }) {
                            HStack{
                                Text(isUserLogged == true ? "Checkout with" : "Checkout")
                                    .padding(15)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                
                                if isUserLogged == true {
                                    URLImage(URL(string: "https://www.pngall.com/wp-content/uploads/15/Apple-Pay-Logo-PNG-Image-File.png")!) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                    }
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                                }
                            }
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
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func updateTotalPrices() {
            var totalPrice: Double = 0.0
            
            for item in selectedItems {
                if let price = item.item?.price, let quantity = item.quantity {
                    totalPrice += price * Double(quantity)
                }
            }
            totalPrices = [totalPrice]
        totalPrices = [totalPrice]
                NotificationCenter.default.post(name: Notification.Name("UpdateCartCount"), object: nil)
        }
}

struct CartItemView: View {
    
    @State var selectedItem: CartSelectedItemElement
    @State private var isShowSelectedItem: Bool = true
    @State var incrementQuantity: Int = 0
    @State private var showDeleteAlert: Bool = false
    @Binding var totalPrices: [Double]
    
    var body: some View {
        
        VStack(spacing: 10) {
            if isShowSelectedItem {
                VStack(spacing: 10) {
                    HStack(spacing: 20) {
                        
                        if let defaultImage = selectedItem.item?.defaultImage {
                                                    URLImage(URL(string: defaultImage)!) { image in
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 60, height: 60)
                                                    }
                                                    .cornerRadius(8)
                                                }
                        
                        
                        VStack(alignment: .leading, spacing: 1) {
                            if let name = selectedItem.item?.name {
                                Text(name)
                                    .font(.system(size: 12))
                                    .fontWeight(.thin)
                                    .foregroundColor(.primary)
                            }
                            Text(selectedItem.selectedSize + "\n")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.orange)
                            
                            if let price = selectedItem.item?.price {
                                
                                if let currentQuantity = selectedItem.quantity {
                                    
                                    let formattedPrice = String(format: "$%.2f", (price * Double(incrementQuantity == 0 ? currentQuantity : incrementQuantity + 1)))
                                            
                                            Text(formattedPrice)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                }
                            }
                        }
                        Spacer()
                        VStack(spacing: 5) {
                            Button(action: {
                                incrementQuantity += 1
                                if var quantity = selectedItem.quantity{
                                    quantity = quantity + 1
                                    updateTotalPrices()
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
                                
                                if incrementQuantity > 0 {
                                    if var quantity = selectedItem.quantity{
                                        quantity = quantity - 1
                                        incrementQuantity -= 1
                                        updateTotalPrices()
                                    }
                                }
                                else{
                                    showDeleteAlert = true
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
    
    private func updateTotalPrices() {
            DispatchQueue.main.async {
                var totalPrice: Double = 0.0
                
                if let price = selectedItem.item?.price, let quantity = selectedItem.quantity {
                    totalPrice += price * Double(quantity + incrementQuantity)
                }
                
                // Update total prices
                totalPrices = [totalPrice]
            }
        }
}

#Preview{
    CartView(isUserLogged: .constant(false))
}
