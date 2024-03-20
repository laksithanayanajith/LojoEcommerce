//
//  ImageViewModel.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//

import Foundation

func fetchImageURL(itemId: Int, sizeId: Int, colorId: Int, completion: @escaping (String?) -> Void) async {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/images/image?itemId=\(itemId)&sizeId=\(sizeId)&colorId=\(colorId)"
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
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        if let imageURLString = String(data: data, encoding: .utf8) {
            completion(imageURLString)
        } else {
            print("Invalid image URL data")
            completion(nil)
        }
    } catch {
        print("Error fetching image: \(error)")
        completion(nil)
    }
}

func fetchImageURL(itemID: Int, completion: @escaping (String?) -> Void) async {
    let baseURLString = "http://laksithanibm-001-site1.jtempurl.com/api/images/image"
    let urlString = "\(baseURLString)?itemId=\(itemID)"
    
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
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        if let imageURLString = String(data: data, encoding: .utf8) {
            completion(imageURLString)
        } else {
            print("Error converting data to string.")
            completion(nil)
        }
    } catch {
        print("Error fetching image URL: \(error)")
        completion(nil)
    }
}
