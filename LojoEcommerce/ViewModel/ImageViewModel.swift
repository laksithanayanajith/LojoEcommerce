//
//  ImageViewModel.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//

import Foundation

import Foundation

func fetchImageURL(itemId: Int, sizeId: Int?, colorId: Int?) async throws -> String? {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/images/image?itemId=\(itemId)&sizeId=\(sizeId ?? 0)&colorId=\(colorId ?? 0)"
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    // Create a base64-encoded credential string
    let username = "11168044"
    let password = "60-dayfreetrial"
    let loginData = "\(username):\(password)".data(using: .utf8)!
    let base64LoginData = loginData.base64EncodedString()
    
    // Attach the Authorization header with the basic authentication credentials
    let authString = "Basic \(base64LoginData)"
    request.setValue(authString, forHTTPHeaderField: "Authorization")
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let imageURLString = String(data: data, encoding: .utf8) else {
            print("Invalid image URL data")
            return nil
        }
        
        return imageURLString
    } catch {
        print("Error fetching image: \(error)")
        return nil
    }
}
