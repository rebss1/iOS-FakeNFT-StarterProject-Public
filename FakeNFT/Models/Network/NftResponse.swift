//
//  NftResponse.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import Foundation

public struct NftResponse: Decodable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}
