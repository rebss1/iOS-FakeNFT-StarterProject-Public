//
//  Cart.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 30.10.2024.
//

import Foundation

struct Cart: Decodable {
    let nfts: [String]
    let id: String
}
