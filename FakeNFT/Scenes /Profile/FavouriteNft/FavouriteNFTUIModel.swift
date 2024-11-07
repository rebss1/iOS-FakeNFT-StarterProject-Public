//
//  FavouriteNFTUIModel.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 24.10.2024.
//

import UIKit

struct FavouriteNFT {
    let name: String
    let imageUrl: String?
    let rating: Int
    let price: Float
    let id: String
    var isLiked: Bool
    
    init(name: String, imageUrl: String?, rating: Int, price: Float, id: String, isLiked: Bool) {
        self.name = name
        self.imageUrl = imageUrl
        self.rating = rating
        self.price = price
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
        self.id = model.id
        self.isLiked = isLiked
    }
}
