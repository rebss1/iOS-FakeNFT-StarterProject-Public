//
//  ProfileUiModel.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 24.10.2024.
//

import UIKit

struct ProfileUIModel {
    var name: String
    var avatar: URL?
    var description: String
    var website: URL?
    var nfts: [String]
    var likes: [String]
    var id: String
    let likedNftsCount: String
    let myNftsCount: String
    
    init(from responseModel: ProfileResponse) {
        name = responseModel.name
        avatar = responseModel.avatar
        description = responseModel.description
        website = responseModel.website
        nfts = responseModel.nfts
        likes = responseModel.likes
        id = responseModel.id
        likedNftsCount = String(responseModel.likes.count)
        myNftsCount = String(responseModel.nfts.count)
    }
}
