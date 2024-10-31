//
//  UpdateProfileRequest.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 30.10.2024.
//

import Foundation

struct UpdateProfileRequest: NetworkRequest {

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }

    var httpMethod = HttpMethod.put

    var body: Data?
    var dto: Dto?
}

struct ProfileDtoObject: Dto {
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
    let likes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name, avatar, description, website, likes
    }
    
    func asDictionary() -> [String: String] {
        var dict = [String: String]()
        dict[CodingKeys.name.rawValue] = name
        dict[CodingKeys.avatar.rawValue] = avatar
        dict[CodingKeys.description.rawValue] = description
        dict[CodingKeys.website.rawValue] = website
        dict[CodingKeys.likes.rawValue] = likes?.joined(separator: ",")
        return dict
    }
}

