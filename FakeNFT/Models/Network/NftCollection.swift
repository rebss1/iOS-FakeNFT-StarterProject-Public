//
//  NftCollection.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 15.10.2024.
//

import Foundation

struct NftCollection: Decodable {
    let createdAt: String
    let name: String
    let cover: URL
    let nfts: [URL]
    let description: String
    let author: String
    let id: String
}
