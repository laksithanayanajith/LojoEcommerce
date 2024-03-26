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
    @State private var isClicked: Bool = false
    
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
                    
                   
                }
                
                HStack{
                    
                    Button(action: {
                    }) {
                        Text("S")
                            .padding(15)
                    }
                    .foregroundColor(isClicked == true ? Color.white : Color.black)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .background(isClicked == true ? Color.black : Color.white)
                    .cornerRadius(50)
                    .padding(.horizontal)
                    
                    Button(action: {
                    }) {
                        Text("M")
                            .padding(15)
                    }
                    .foregroundColor(isClicked == true ? Color.white : Color.black)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .background(isClicked == true ? Color.black : Color.white)
                    .cornerRadius(50)
                    .padding(.horizontal)
                    
                    Button(action: {
                    }) {
                        Text("L")
                            .padding(15)
                    }
                    .foregroundColor(isClicked == true ? Color.white : Color.black)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .background(isClicked == true ? Color.black : Color.white)
                    .cornerRadius(50)
                    .padding(.horizontal)
                    
                    Button(action: {
                    }) {
                        Text("L")
                            .padding(15)
                    }
                    .foregroundColor(isClicked == true ? Color.white : Color.black)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .background(isClicked == true ? Color.black : Color.white)
                    .cornerRadius(50)
                    .padding(.horizontal)
                }
                
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
                Text(item.description)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .opacity(0.8)
                
                Button(action: {
                }) {
                    Text("Add To Cart")
                        .padding(15)
                }
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.black, lineWidth: 1)
                )
                .background(Color.black)
                .cornerRadius(50)
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
            ItemView(itemId: 1)
        }
    }
}
