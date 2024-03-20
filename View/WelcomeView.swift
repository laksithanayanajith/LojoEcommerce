//
//  WelcomeView.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//

import SwiftUI
import URLImage

struct WelcomeView: View {
    
    var body: some View {
        
        ZStack {
            
            URLImage(URL(string: "https://images.pexels.com/photos/8557408/pexels-photo-8557408.jpeg")!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .background()
            }
            
            ZStack{
                
                Rectangle()
                    .foregroundColor(Color.black.opacity(1))
                    .frame(minWidth: 200, maxWidth: 250, minHeight: 200, maxHeight: 250)
                    .edgesIgnoringSafeArea(.all)
                    .cornerRadius(40)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        
                
                VStack {
                    Text("LOJO")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\n Discover the perfect blend \n of style and functionality \n with our curated collection \n of men's jackets.")
                        .font(.callout)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: HomeView()) {
                        Text("\n Explore Now")
                            .font(.callout)
                            .fontWeight(.light)
                            .foregroundColor(.accentColor)
                    }
                }
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

