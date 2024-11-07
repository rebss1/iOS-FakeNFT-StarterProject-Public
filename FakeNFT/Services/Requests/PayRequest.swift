//
//  PayRequest.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 05.11.2024.
//

import Foundation

struct PayRequest: NetworkRequest {
    let id: String
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1/payment/\(id)")
    }
    var httpMethod: HttpMethod = .get
    var dto: Dto?
}

