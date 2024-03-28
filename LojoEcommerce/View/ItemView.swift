//
//  ItemView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//
import SwiftUI
import URLImage

struct ItemView: View {
    
    let itemId: Int
    @State private var isLoading = true
    @State private var item: ItemElement?
    @State private var isShowDefaultImage: Bool = true
    @State private var isClickedSmall: Bool = false
    @State private var isClickedMedium: Bool = false
    @State private var isClickedLarge: Bool = false
    @State private var isClickedXLarge: Bool = false
    @State private var isClickedXXLarge: Bool = false
    @State var selectedItem: SelectedItemElement?
    @State var currentSelectedItem: CurrentSelectedItemElement?
    @State var showAlert: Bool?
    @State var alertMessage: String = "The selected jacket added to the cart now!"
    
    var body: some View {
        
        VStack {
            if isLoading {
                ProgressView()
            } else if let item = item {
                if isShowDefaultImage{
                    if let imageURL = URL(string: item.defaultImage) {
                        URLImage(imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
                else{
                    
                    if let imageURL = URL(string: "https://img.freepik.com/premium-vector/sold-out-stamp-design-black-color_500223-261.jpg?w=2000") {
                        URLImage(imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
                
                HStack{
                    
                    Button(action: {
                        
                        if isClickedSmall == false {
                            isShowDefaultImage = true
                        }
                        
                        isClickedSmall = !isClickedSmall
                        isClickedMedium = false
                        isClickedLarge = false
                        isClickedXLarge = false
                        isClickedXXLarge = false
                        
                        currentSelectedItem = CurrentSelectedItemElement(id: item.id,
                                                                         name: item.name,
                                                                         description: item.description,
                                                                         price: item.price,
                                                                         category: item.category,
                                                                         defaultImage: item.defaultImage,
                                                                         addedDate: item.addedDate,
                                                                         images: item.images,
                                                                         colors: item.colors,
                                                                         sizes: item.sizes)
                        
                        selectedItem = SelectedItemElement(id: 0, quantity: 1, totalPrice: item.price, selectedSize: "Small", itemID: item.id, item: currentSelectedItem)
                        
                    }) {
                        Text("S")
                    }
                    .foregroundColor(isClickedSmall == true ? Color.white : Color.black)
                    .frame(width: 40, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .background(isClickedSmall == true ? Color.black : Color.white)
                    .cornerRadius(50)
                    
                    Button(action: {
                        
                        if isClickedMedium == false {
                            isShowDefaultImage = true
                        }
                        
                        isClickedSmall = false
                        isClickedMedium = !isClickedMedium
                        isClickedLarge = false
                        isClickedXLarge = false
                        isClickedXXLarge = false
                        
                        currentSelectedItem = CurrentSelectedItemElement(id: item.id,
                                                                         name: item.name,
                                                                         description: item.description,
                                                                         price: item.price,
                                                                         category: item.category,
                                                                         defaultImage: item.defaultImage,
                                                                         addedDate: item.addedDate,
                                                                         images: item.images,
                                                                         colors: item.colors,
                                                                         sizes: item.sizes)
                        
                        selectedItem = SelectedItemElement(id: 0, quantity: 1, totalPrice: item.price, selectedSize: "Medium", itemID: item.id, item: currentSelectedItem)
                        
                    }) {
                        Text("M")
                    }
                    .foregroundColor(isClickedMedium == true ? Color.white : Color.black)
                    .frame(width: 40, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .background(isClickedMedium == true ? Color.black : Color.white)
                    .cornerRadius(50)
                    
                    Button(action: {
                        
                        if isClickedLarge == false {
                            isShowDefaultImage = true
                        }
                        
                        isClickedSmall = false
                        isClickedMedium = false
                        isClickedLarge = !isClickedLarge
                        isClickedXLarge = false
                        isClickedXXLarge = false
                        
                        currentSelectedItem = CurrentSelectedItemElement(id: item.id,
                                                                         name: item.name,
                                                                         description: item.description,
                                                                         price: item.price,
                                                                         category: item.category,
                                                                         defaultImage: item.defaultImage,
                                                                         addedDate: item.addedDate,
                                                                         images: item.images,
                                                                         colors: item.colors,
                                                                         sizes: item.sizes)
                        
                        selectedItem = SelectedItemElement(id: 0, quantity: 1, totalPrice: item.price, selectedSize: "Large", itemID: item.id, item: currentSelectedItem)
                        
                    }) {
                        Text("L")
                    }
                    .foregroundColor(isClickedLarge == true ? Color.white : Color.black)
                    .frame(width: 40, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .background(isClickedLarge == true ? Color.black : Color.white)
                    .cornerRadius(50)
                    
                    Button(action: {
                        
                        if isClickedXLarge == false {
                            isShowDefaultImage = true
                        }
                        
                        isClickedSmall = false
                        isClickedMedium = false
                        isClickedLarge = false
                        isClickedXLarge = !isClickedXLarge
                        isClickedXXLarge = false
                        
                        currentSelectedItem = CurrentSelectedItemElement(id: item.id,
                                                                         name: item.name,
                                                                         description: item.description,
                                                                         price: item.price,
                                                                         category: item.category,
                                                                         defaultImage: item.defaultImage,
                                                                         addedDate: item.addedDate,
                                                                         images: item.images,
                                                                         colors: item.colors,
                                                                         sizes: item.sizes)
                        
                        selectedItem = SelectedItemElement(id: 0, quantity: 1, totalPrice: item.price, selectedSize: "XL", itemID: item.id, item: currentSelectedItem)
                        
                    }) {
                        Text("XL")
                    }
                    .foregroundColor(isClickedXLarge == true ? Color.white : Color.black)
                    .frame(width: 40, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .background(isClickedXLarge == true ? Color.black : Color.white)
                    .cornerRadius(50)
                    
                    Button(action: {
                        
                        if isClickedXXLarge == false {
                            isShowDefaultImage = false
                        }
                        
                        isClickedSmall = false
                        isClickedMedium = false
                        isClickedLarge = false
                        isClickedXLarge = false
                        isClickedXXLarge = !isClickedXXLarge
                        
                        currentSelectedItem = CurrentSelectedItemElement(id: item.id,
                                                                         name: item.name,
                                                                         description: item.description,
                                                                         price: item.price,
                                                                         category: item.category,
                                                                         defaultImage: item.defaultImage,
                                                                         addedDate: item.addedDate,
                                                                         images: item.images,
                                                                         colors: item.colors,
                                                                         sizes: item.sizes)
                        
                        selectedItem = SelectedItemElement(id: 0, quantity: 1, totalPrice: item.price, selectedSize: "2XL", itemID: item.id, item: currentSelectedItem)
                        
                    }) {
                        Text("2XL")
                    }
                    .foregroundColor(isClickedXXLarge == true ? Color.white : Color.black)
                    .frame(width: 40, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .background(isClickedXXLarge == true ? Color.black : Color.white)
                    .cornerRadius(50)
                }.padding(.vertical)
                
                Text((item.name) + "\n")
                    .font(.headline)
                    .fontWeight(.medium)
                    .opacity(0.5)
                    .padding(.horizontal)
                Text("$\(String(format: "%.2f", item.price))")
                    .font(.system(.largeTitle))
                    .fontWeight(.bold)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text(item.description)
                    .foregroundColor(.black)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .opacity(0.8)
                    .padding(.horizontal, 19)
                
                    Button(action: {
                        Task {
                            if let selectedItem = selectedItem {
                                await createSelectedItem(selectedItem: selectedItem) { fail in
                                    if fail == false {
                                        showAlert = true
                                        print("Item added to cart successfully.")
                                    } else {
                                        showAlert = true
                                        alertMessage = "Can't add the selected one right now!"
                                        print("Failed to add item to cart.")
                                    }
                                }
                            } else {
                                print("Cannot find selected item!")
                            }
                        }
                    }) {
                        Text("Add To Cart")
                            .padding(15)
                            .foregroundColor(.white)
                    }
                    .disabled(!((isClickedSmall == true || isClickedMedium == true || isClickedLarge == true || isClickedXLarge == true || isClickedXXLarge == true) && isShowDefaultImage == true))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 0)
                    )
                    .background((isClickedSmall == true || isClickedMedium == true || isClickedLarge == true || isClickedXLarge == true || isClickedXXLarge == true) && isShowDefaultImage == true ? Color.black : Color.gray)
                    .cornerRadius(50)
                    .opacity((isClickedSmall == true || isClickedMedium == true || isClickedLarge == true || isClickedXLarge == true || isClickedXXLarge == true) && isShowDefaultImage == true ? 1.0 : 0.6)
                    .alert(isPresented: Binding<Bool>(
                        get: { showAlert ?? false },
                        set: { showAlert = $0 }
                    )) {
                        Alert(title: Text("Add to Cart"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                    .padding()
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
            ItemView(itemId: 1, selectedItem: nil)
        }
    }
}
