//
//  SelectedItemModel.swift
//  LojoEcommerce
//
//  Created by NIBMPC04PC03 on 2024-03-28.
//

import Foundation

struct SelectedItemElement: Identifiable, Codable, Equatable {
    let id, quantity: Int
    let totalPrice: Double
    let selectedSize: String
    let itemID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, quantity, totalPrice, selectedSize, itemID
    }
}

struct CartSelectedItemElement: Identifiable, Codable, Equatable {
    let id, quantity: Int?
    let totalPrice: Double
    let selectedSize: String
    let itemID: Int?
    let item: CurrentSelectedItemElement?
    
    enum CodingKeys: String, CodingKey {
        case id, quantity, totalPrice, selectedSize, itemID, item
    }
}

struct CurrentSelectedItemElement: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let category: String
    //let defaultImage: String
    let addedDate: String
}
