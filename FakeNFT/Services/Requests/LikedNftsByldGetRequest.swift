//
//  LikedNftsByldGetRequest.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 30.10.2024.
//

import Foundation

struct LikedNftsGetRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod = .get
    var dto: Dto?
}
