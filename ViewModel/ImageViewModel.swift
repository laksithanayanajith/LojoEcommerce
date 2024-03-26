//
//  ImageViewModel.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//

import Foundation

func fetchImageURL(itemId: Int, sizeId: Int?, colorId: Int?, completion: @escaping (String?) -> Void) {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/images/image?itemId=\(itemId)&sizeId=\(sizeId ?? 0)&colorId=\(colorId ?? 0)"
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        completion(nil)
        return
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
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error fetching image: \(error)")
            completion(nil)
            return
        }
        
        guard let data = data, let imageURLString = String(data: data, encoding: .utf8) else {
            print("Invalid image URL data")
            completion(nil)
            return
        }
        
        completion(imageURLString)
    }.resume()
}
