//
//  LikedNftsByldPutRequest.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 24.10.2024.
//

import Foundation

struct LikedNftsPutRequest: NetworkRequest {
   var endpoint: URL? {
       URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
   }
   var httpMethod: HttpMethod = .put
   var dto: Dto?
}

struct LikedNftsDtoObject: Dto {
    let likedNfts: [String]?

    enum CodingKeys: String, CodingKey {
        case likedNfts = "likes"
    }

    func asDictionary() -> [String : String] {
        if let likedNfts = likedNfts {
            return [CodingKeys.likedNfts.rawValue: likedNfts.joined(separator: ",")]
        } else {
            return [:]
        }
    }
}

struct LikedNftsPutResponse: Decodable {
    let likedNfts: String?
    
//    func asArray() -> [String] {
//        if let likedNfts = likedNfts {
//            return likedNfts.components(separatedBy: ",")
//        } else {
//            return []
//        }
//    }
}
