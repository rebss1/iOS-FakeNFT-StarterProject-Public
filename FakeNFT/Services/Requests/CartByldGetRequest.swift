//
//  CartByldGetRequest.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 30.10.2024.
//

import Foundation

struct CartGetRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod = .get
    var dto: Dto?
}

