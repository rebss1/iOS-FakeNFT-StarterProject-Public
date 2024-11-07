//
//  FetchProfileRequest.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import Foundation

struct FetchProfileRequest: NetworkRequest {
    let id: String

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/\(id)")
    }

    var httpMethod: HttpMethod {
        .get
    }
    
    var dto: Dto?
}
