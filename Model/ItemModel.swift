//
//  ItemModel.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//
import Foundation

struct ItemElement: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let category: String
    let defaultImage: String
    let addedDate: String
    let selectedItem: JSONNullItems?
    let images: JSONNullItems?
    let colors: JSONNullItems?
    let sizes: JSONNullItems?
}

typealias Item = [ItemElement]

class JSONNullItems: Identifiable, Codable {
    init() {}
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullItems.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
