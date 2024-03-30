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

func deleteSelectedItem(id: Int, completion: @escaping (Bool) -> Void) async {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/selectedItems/\(id)"
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        completion(false)
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
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
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 204 {
                // Successfully deleted
                completion(true)
            } else {
                // Failed to delete
                print("Failed to delete. Status code: \(httpResponse.statusCode)")
                completion(false)
            }
        } else {
            print("Invalid response from server")
            completion(false)
        }
        
    } catch {
        print("Error deleting selected item: \(error)")
        completion(false)
    }
}

func updateSelectedItem(id: Int, selectedItem: SelectedItemElement, completion: @escaping (Bool) -> Void) async {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/selectedItems/\(id)"
    
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        completion(false)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Your username and password (consider secure storage for real applications)
    let username = "11168044"
    let password = "60-dayfreetrial"
    
    // Create a base64-encoded credential string
    let loginString = "\(username):\(password)"
    guard let loginData = loginString.data(using: .utf8) else {
        print("Error encoding login data")
        completion(false)
        return
    }
    let base64LoginData = loginData.base64EncodedString()
    
    // Attach the Authorization header with the basic authentication credentials
    let authString = "Basic \(base64LoginData)"
    request.setValue(authString, forHTTPHeaderField: "Authorization")
    
    // Encode the selectedItem object as JSON data
    do {
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(selectedItem)
        request.httpBody = jsonData
    } catch {
        print("Error encoding selected item: \(error)")
        completion(false)
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error updating selected item: \(error)")
            completion(false)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response from server")
            completion(false)
            return
        }
        
        if httpResponse.statusCode == 200 {
            // Successfully updated
            print("Successfully updated. Status code: \(httpResponse.statusCode)")
            completion(true)
        } else {
            // Failed to update
            print("Failed to update. Status code: \(httpResponse.statusCode)")
            completion(false)
        }
    }
    
    task.resume()
}

func fetchSubTotal(completion: @escaping (Double?) -> Void) {
    let urlString = "http://laksithanibm-001-site1.jtempurl.com/api/selectedItems/subtotal"
    
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    // Your username and password (consider secure storage for real applications)
    let username = "11168044"
    let password = "60-dayfreetrial"
    
    // Create a base64-encoded credential string
    let loginString = "\(username):\(password)"
    guard let loginData = loginString.data(using: .utf8) else {
        print("Error encoding login data")
        completion(nil)
        return
    }
    let base64LoginData = loginData.base64EncodedString()
    
    // Attach the Authorization header with the basic authentication credentials
    let authString = "Basic \(base64LoginData)"
    request.setValue(authString, forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error fetching subtotal: \(error)")
            completion(nil)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response from server")
            completion(nil)
            return
        }
        
        guard let responseData = data else {
            print("No data received")
            completion(nil)
            return
        }
        
        if httpResponse.statusCode == 200 {
            do {
                // Decode the response data to extract the subtotal
                let decoder = JSONDecoder()
                let subtotalResponse = try decoder.decode(Double.self, from: responseData)
                completion(subtotalResponse)
            } catch {
                print("Error decoding subtotal response: \(error)")
                completion(nil)
            }
        } else {
            // Failed to fetch subtotal
            print("Failed to fetch subtotal. Status code: \(httpResponse.statusCode)")
            completion(nil)
        }
    }
    
    task.resume()
}
