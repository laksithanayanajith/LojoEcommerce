//
//  ItemModel.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//
import Foundation

struct ItemElement: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let category: String
    let defaultImage: String
    let addedDate: String
    let images: JSONNullItems?
    let colors: JSONNullItems?
    let sizes: JSONNullItems?
}

class JSONNullItems: Identifiable, Codable, Equatable {
    init() {}
    static func == (lhs: JSONNullItems, rhs: JSONNullItems) -> Bool {
        return true
    }
}

