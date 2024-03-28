//
//  SelectedItemViewModel.swift
//  LojoEcommerce
//
//  Created by NIBMPC04PC03 on 2024-03-28.
//

import Foundation

struct CreateSelectedItemResponse: Decodable {
    let success: Bool
}

func createSelectedItem(selectedItem: SelectedItemElement, completion: @escaping (Bool) -> Void) async {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/selectedItems/"
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        completion(false)
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    // Your username and password
    let username = "11168044"
    let password = "60-dayfreetrial"

    // Create a base64-encoded credential string
    let loginString = "\(username):\(password)"
    let loginData = loginString.data(using: .utf8)!
    let base64LoginData = loginData.base64EncodedString()

    // Attach the Authorization header with the basic authentication credentials
    let authString = "Basic \(base64LoginData)"
    request.setValue(authString, forHTTPHeaderField: "Authorization")

    do {
        let jsonData = try JSONEncoder().encode(selectedItem)
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(CreateSelectedItemResponse.self, from: data)
        completion(response.success)
        
    } catch {
        print("Error creating selected item: \(error)")
        completion(false)
    }
}

func fetchSelectedItems(completion: @escaping ([CartSelectedItemElement]?) -> Void) async {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/selectedItems"
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
        guard let data = data else {
            print("No data received: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
            return
        }
        
        do {
            let items = try JSONDecoder().decode([CartSelectedItemElement].self, from: data)
            completion(items)
        } catch {
            print("Error decoding JSON: \(error)")
            completion(nil)
        }
    }.resume()
}
