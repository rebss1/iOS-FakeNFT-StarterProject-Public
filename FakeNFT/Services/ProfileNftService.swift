//
//  ProfileNftService.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import Foundation

typealias ProfileNftCompletion = (Result<NftModel, Error>) -> Void

protocol ProfileNftService {
    func loadNft(id: String, completion: @escaping ProfileNftCompletion)
}

final class ProfileNftServiceImpl: ProfileNftService {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func loadNft(id: String, completion: @escaping ProfileNftCompletion) {
        let request = NFTRequest(id: id)
        networkClient.send(request: request, type: NftResponse.self) { result in
            switch result {
            case .success(let nft):
                completion(.success(NftModel(nft)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
