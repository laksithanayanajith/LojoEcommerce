//
//  CustomTabView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-27.
//

import SwiftUI
import URLImage

struct CustomTabView: View {
    
    @Binding var tabSelection: Int
    @State private var selectedItemsCount: Int = 0
    
    let tabBarItem: [(title: String, iconUrl: String)] = [
        ("home", "https://img.icons8.com/ios-filled/50/home.png"),
        ("search", "https://img.icons8.com/puffy-filled/32/search.png"),
        ("cart", "https://img.icons8.com/glyph-neue/64/shopping-cart.png")
    ]
    var body: some View {
        
        ZStack{
            Capsule().frame(width: .infinity, height: 60)
                .padding(.horizontal)
                .foregroundColor(.white)
                .shadow(radius: 5)
            
            HStack{
                ForEach(0..<3) { index in
                    Button{
                        tabSelection = index + 1
                    } label: {
                        VStack(spacing: 8) {
                            Spacer()
                            URLImage(URL(string: tabBarItem[index].iconUrl)!) { image in
                                                            image
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 30, height: 30)
                                                                .opacity(0.9)
                                                                .padding(.horizontal, 10)
                            }
                            Spacer()
                        }
                    }
                    
                    if index == 2 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 50)
                                .foregroundColor(.black)
                                .frame(width: selectedItemsCount < 9 ? 30 : 60, height: 30)
                            Text(String(selectedItemsCount))
                                .font(.callout)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.orange)
                                .padding(.horizontal)
                        }
                        .padding(.horizontal,-20)
                    }
                }
            }
            .frame(height: 60)
        }
        .foregroundColor(.clear)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            Task{
                await fetchSelectedItems { items in
                            if let items = items {
                                DispatchQueue.main.async {
                                    selectedItemsCount = items.count
                                }
                            }
                        }
            }
        }
        .onAppear{
            Task{
                await fetchSelectedItems { items in
                            if let items = items {
                                DispatchQueue.main.async {
                                    selectedItemsCount = items.count
                                }
                            }
                        }
            }
        }
    }
}

#Preview {
    CustomTabView(tabSelection: .constant(1))
        .previewLayout(.sizeThatFits)
        .padding(.vertical)
}
