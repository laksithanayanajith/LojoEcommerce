//
//  ItemViewModel.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//
import Foundation

struct ItemsResponse: Codable {
    let items: [ItemElement]
}

func fetchItems(completion: @escaping ([ItemElement]?) -> Void) async {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/items"
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
            let items = try JSONDecoder().decode([ItemElement].self, from: data)
            completion(items)
        } catch {
            print("Error decoding JSON: \(error)")
            completion(nil)
        }
    }.resume()
}

func fetchItemsById(id: Int) async throws -> ItemElement? {
    let url = URL(string: "http://laksithanibm-001-site1.jtempurl.com/api/items/\(id)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let item = try JSONDecoder().decode(ItemElement.self, from: data)
    return item
}

func fetchSearchItems(byName name: String, completion: @escaping ([ItemElement]?) -> Void) async {
    
    let searchURLString = "http://laksithanibm-001-site1.jtempurl.com/api/items/search?name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
    
    guard let url = URL(string: searchURLString) else {
        print("Invalid URL: \(searchURLString)")
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
        let items = try JSONDecoder().decode([ItemElement].self, from: data)
        completion(items)
    } catch {
        print("Error fetching items: \(error)")
        completion(nil)
    }
}

func fetchItemsByPrice(completion: @escaping ([ItemElement]?) -> Void) async {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/items/prices"
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
        let items = try JSONDecoder().decode([ItemElement].self, from: data)
        completion(items)
    } catch {
        print("Error fetching items by price: \(error)")
        completion(nil)
    }
}

func fetchItemsByAddedDate(completion: @escaping ([ItemElement]?) -> Void) async {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/items/date"
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
        let items = try JSONDecoder().decode([ItemElement].self, from: data)
        completion(items)
    } catch {
        print("Error fetching items by price: \(error)")
        completion(nil)
    }
}
