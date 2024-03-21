//
//  SearchView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//

import SwiftUI
import URLImage

struct SearchView: View {
    
    @State private var searchQuery = ""
    @State private var isLoading = true
    @State private var items: [ItemElement] = []
    @State private var sortOption: SortOption = .price
    
    var body: some View {
        ZStack {
            VStack {
                if isLoading {
                    ProgressView()
                }
                
                if !isLoading {
                    Text("LOJO")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("What Are You Looking For Today?")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .opacity(0.8)
                    
                    TextField("Search", text: $searchQuery, onCommit: {
                        searchItems()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: .infinity, height: .infinity)
                    .padding(.bottom)
                    .padding(.horizontal)
                    
                    HStack {
                        Button(action: {
                            sortOption = .price
                            fetchSearchItemsByPrice()
                        }) {
                            Text("Price")
                                .padding(12)
                        }
                        .background(.white)
                        .foregroundColor(sortOption == .price ? Color.black : Color.gray)
                        .frame(maxWidth: 120)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(sortOption == .price ? Color.black : Color.gray, lineWidth: 1)
                        )
                        
                        Button(action: {
                            sortOption = .addedDate
                            fetchSearchItemsByAddedDate()
                        }) {
                            Text("Added Date")
                                .padding(12)
                        }
                        .foregroundColor(sortOption == .addedDate ? Color.black : Color.gray)
                        .frame(maxWidth: 190)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(sortOption == .addedDate ? Color.black : Color.gray, lineWidth: 1)
                        )
                        
                        Button(action: {
                            // Handle button action here
                        }) {
                            if let imageURL = URL(string: "https://img.icons8.com/ios-filled/50/filter--v1.png") {
                                URLImage(imageURL) { image in
                                    image
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .scaledToFit()
                                }
                            } else {
                                // Placeholder image or error handling if URL is invalid
                                Text("Image Not Found")
                            }
                        }
                        .padding(.vertical)

                        
                    }
                    .padding(.bottom)

                    
                    HStack {
                        VStack {
                            ForEach(items.filter { $0.id % 2 == 0 }) { item in
                                RectangleItemView(item: item)
                            }
                        }
                        
                        VStack {
                            ForEach(items.filter { $0.id % 2 != 0 }) { item in
                                RectangleItemView(item: item)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            Task {
                await fetchItems { items in
                    isLoading = false
                    if let items = items {
                        self.items = items
                    }
                }
            }
        }
    }
    
    private func searchItems() {
        isLoading = true
        Task {
            await fetchSearchItems(byName: searchQuery) { searchedItems in
                isLoading = false
                if let searchedItems = searchedItems {
                    self.items = searchedItems
                }
            }
        }
    }
    
    private func fetchSearchItemsByPrice() {
            isLoading = true
            Task {
                await fetchItemsByPrice { sortedItems in
                    isLoading = false
                    if let sortedItems = sortedItems {
                        self.items = sortedItems
                }
            }
        }
    }
    
    private func fetchSearchItemsByAddedDate() {
            isLoading = true
            Task {
                await fetchItemsByAddedDate { sortedItems in
                    isLoading = false
                    if let sortedItems = sortedItems {
                        self.items = sortedItems
                }
            }
        }
    }
}

struct RectangleItemView: View {
    let item: ItemElement
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color.white)
            .frame(minWidth: 100, maxWidth: 250, minHeight: 100, maxHeight: 250)
            .cornerRadius(20)
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .opacity(0.8)
            .overlay(
                VStack(spacing: 0) {
                    URLImage(URL(string: item.defaultImage)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("$\(String(format: "%.2f", item.price))")
                            .font(.headline)
                            .foregroundColor(.black)
                            .opacity(0.9)
                        Text(item.name)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
                        Text(item.description)
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .opacity(0.8)
                    }
                    .padding()
                }
            )
    }
}

enum SortOption {
    case price
    case addedDate
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

