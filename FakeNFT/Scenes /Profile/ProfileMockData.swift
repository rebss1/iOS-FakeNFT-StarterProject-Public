//
//  ProfileMockData.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import Foundation

let mockMyNfts = [
    MyNFT(
        name: "Lilo",
        imageUrl: "https://printstorm.ru/wp-content/uploads/2021/08/pokemon-07-1024x1024.jpg",
        rating: 3,
        price: 1.78,
        author: "John Doe",
        id:"1",
        isLiked: true
    ),
    MyNFT(
        name: "Spring",
        imageUrl: "https://staticg.sportskeeda.com/wp-content/uploads/2016/09/eevee-1474440362-800.jpg",
        rating: 3,
        price: 1.78,
        author: "John Doe",
        id: "2",
        isLiked: false
    ),
    MyNFT(
        name: "April",
        imageUrl: "https://yobte.ru/uploads/posts/2019-11/pokemony-42-foto-35.png",
        rating: 3,
        price: 1.78,
        author: "John Doe",
        id: "3",
        isLiked: false
    ),
]

let mockFavouriteNfts = [
    FavouriteNFT(
        name: "Archie",
        imageUrl: "https://printstorm.ru/wp-content/uploads/2021/08/pokemon-07-1024x1024.jpg",
        rating: 1,
        price: 1.78,
        id: "1",
        isLiked: true
    ),
    FavouriteNFT(
        name: "Pixi",
        imageUrl: "https://staticg.sportskeeda.com/wp-content/uploads/2016/09/eevee-1474440362-800.jpg",
        rating: 3,
        price: 1.78,
        id: "2",
        isLiked: true
    ),
    FavouriteNFT(
        name: "Melissa",
        imageUrl: "https://yobte.ru/uploads/posts/2019-11/pokemony-42-foto-35.png",
        rating: 5,
        price: 1.78,
        id: "3",
        isLiked: true
    ),
    FavouriteNFT(
        name: "April",
        imageUrl: "https://i.pinimg.com/originals/cd/8a/13/cd8a13b918337e918973242208084ebf.jpg",
        rating: 2,
        price: 1.78,
        id: "4",
        isLiked: true
    ),
]

//MARK: - Strings for labels

enum ProfileConstants {
    static let profileId = "1"
    static let profileNameString = " "
    static let profileBioString = " "
    static let profileWebLinkString = " "
    static let developerLink = " "
}

