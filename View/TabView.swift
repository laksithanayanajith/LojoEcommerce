//
//  TabView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-27.
//

import SwiftUI
import URLImage

struct TabView: View {
    
    @Binding var tabSelection: Int
    
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
                }
            }
            .frame(height: 60)
        }
        .foregroundColor(.clear)
    }
}

#Preview {
    TabView(tabSelection: .constant(1))
        .previewLayout(.sizeThatFits)
        .padding(.vertical)
}
