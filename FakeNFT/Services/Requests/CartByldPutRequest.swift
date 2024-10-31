//
//  CartByldPutRequest.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 30.10.2024.
//

import Foundation

struct CartPutRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod = .put
    var dto: Dto?
}

struct CartDtoObject: Dto {
    let nfts: [String]?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case nftsInCart = "nfts"
        case id = "id"
    }

    func asDictionary() -> [String: String] {
        var dict: [String: String] = [:]
        if let nfts {
            dict[CodingKeys.nftsInCart.rawValue] = nfts.joined(separator: ",")
        }
        if let id {
            dict[CodingKeys.id.rawValue] = id
        }
        return dict
    }
}
