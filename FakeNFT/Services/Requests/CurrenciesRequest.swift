//
//  CurrenciesGetRequest.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 03.11.2024.
//

import Foundation

struct CurrencyRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/currencies")
    }
    var httpMethod: HttpMethod = .get
    var dto: Dto?
}


//struct CurrenciesGetRequest: NetworkRequest {
//    let id: String
//    var endpoint: URL? {
//        URL(string: "\(RequestConstants.baseURL)/api/v1/currencies/\(id)")
//    }
//    var httpMethod: HttpMethod = .get
//    var dto: Dto?
//}

