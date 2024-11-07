//
//  OrderGetRequest.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 03.11.2024.
//

import Foundation

struct OrderGetRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod = .get
    var dto: Dto?
}

struct OrderPutRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod = .put
    var dto: Dto?
}

struct OrderDtoObject: Dto {
    let nfts: [String]?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case nfts = "nfts"
        case id = "id"
    }

    func asDictionary() -> [String: String] {
        var dict: [String: String] = [:]
        if let nfts {
            dict[CodingKeys.nfts.rawValue] = nfts.joined(separator: ",")
        }
        if let id {
            dict[CodingKeys.id.rawValue] = id
        }
        return dict
    }
}
