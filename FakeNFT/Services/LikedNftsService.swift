//
//  LikedNftsService.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 24.10.2024.
//

import Foundation

typealias LikedNftsGetCompletion = (Result<Likes, Error>) -> Void
typealias LikedNftsPutCompletion = (Result<Bool, Error>) -> Void

protocol LikedNftsService {
    func sendLikedNftsPutRequest(
        likedNfts: [String],
        completion: @escaping LikedNftsPutCompletion
    )
    func sendLikedNftsGetRequest(completion: @escaping LikedNftsGetCompletion)
}

final class LikedNftsServiceImpl: LikedNftsService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func sendLikedNftsGetRequest(completion: @escaping LikedNftsGetCompletion) {
        let request = LikedNftsGetRequest()
        networkClient.send(request: request, type: Likes.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let likes):
                    completion(.success(likes))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func sendLikedNftsPutRequest(likedNfts: [String], completion: @escaping LikedNftsPutCompletion) {
        let dto = LikedNftsDtoObject(likedNfts: likedNfts)
        let request = LikedNftsPutRequest(dto: dto)
        networkClient.send(request: request) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
