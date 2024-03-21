
//
//  SearchView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//

import SwiftUI
import URLImage

struct HomeView: View {
    
    @State private var isLoading = true
    @State private var items: [ItemElement] = []
    
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
                }
                
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
    
       struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
