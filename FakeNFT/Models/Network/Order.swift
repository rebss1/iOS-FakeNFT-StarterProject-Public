//
//  Order.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 02.11.2024.
//

import Foundation

struct Order: Decodable {
    let nfts: [String]
    let id: String
}
