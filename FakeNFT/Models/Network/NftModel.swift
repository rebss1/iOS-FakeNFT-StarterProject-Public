//
//  NftModel.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import Foundation

struct NftModel {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
    
    init(createdAt: String, name: String, images: [String], rating: Int, description: String, price: Float, author: String, id: String) {
        self.createdAt = createdAt
        self.name = name
        self.images = images
        self.rating = rating
        self.description = description
        self.price = price
        self.author = author
        self.id = id
    }
    
    init(_ response: NftResponse) {
        self.createdAt = response.createdAt
        self.name = response.name
        self.images = response.images
        self.rating = response.rating
        self.description = response.description
        self.price = response.price
        self.author = response.author
        self.id = response.id
    }
}

extension NftModel {
    
    func isLiked(_ likedNfts: [String]) -> Bool {
        likedNfts.contains(id)
    }
}
