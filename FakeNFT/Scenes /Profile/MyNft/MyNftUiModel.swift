//
//  MyNftUiModel.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 24.10.2024.
//

import UIKit

struct MyNFT {
    let name: String
    let imageUrl: String?
    let rating: Int
    let price: Float
    let author: String
    let id: String
    var isLiked: Bool
    
    init(name: String, imageUrl: String?, rating: Int, price: Float, author: String, id: String, isLiked: Bool ) {
        self.name = name
        self.imageUrl = imageUrl
        self.rating = rating
        self.price = price
        self.author = author
        self.id = id
        self.isLiked = isLiked
    }
    
    init(
        _ model: NftModel,
        isLiked: Bool
    ) {
        self.name = model.name
        self.imageUrl = model.images.first
        self.rating = model.rating
        self.price = model.price
        self.author = model.author
        self.id = model.id
        self.isLiked = isLiked
    }
}
