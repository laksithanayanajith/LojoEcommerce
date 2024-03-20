//
//  ImageModel.swift
//  LojoEcommerce
//
//  Created by NIBM-LAB04-PC05 on 2024-03-20.
//

import Foundation

import Foundation

struct ImageElement: Codable {
    let id: Int
    let url: URL
    let itemId: Int
    let item: String?
    let colorId, sizeId: Int

    enum CodingKeys: String, CodingKey {
        case id, url
        case itemId = "itemID"
        case item
        case colorId = "colorID"
        case sizeId = "sizeID"
    }
}

typealias Image = [ImageElement]

class JSONNullImages: Codable {
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
