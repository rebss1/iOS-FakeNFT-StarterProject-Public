//
//  LikedNftsService.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 24.10.2024.
//

import Foundation

typealias LikedNftsPutCompletion = (Result<LikedNftsPutResponse, Error>) -> Void

protocol LikedNftsService {
    func sendLikedNftsPutRequest(
        likedNfts: [String],
        completion: @escaping LikedNftsPutCompletion
    )
}

final class LikedNftsServiceImpl: LikedNftsService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func sendLikedNftsPutRequest(likedNfts: [String], completion: @escaping LikedNftsPutCompletion) {
        let dto = LikedNftsDtoObject(likedNfts: likedNfts)
        let request = LikedNftsPutRequest(dto: dto)
        networkClient.send(request: request, type: LikedNftsPutResponse.self) { result in
            switch result {
            case .success(let putResponse):
                completion(.success(putResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
