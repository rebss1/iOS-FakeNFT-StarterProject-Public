//
//  Currencies.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 02.11.2024.
//

import Foundation

struct Currency: Decodable {
    let title: String
    let name: String
    let image: URL
    let id: String
}
