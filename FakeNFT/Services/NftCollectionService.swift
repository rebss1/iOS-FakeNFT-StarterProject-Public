//
//  NftCollectionService.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 15.10.2024.
//

import Foundation

typealias NftCollectionCompletion = (Result<[NftCollection], Error>) -> Void

protocol NftCollectionService {
    func loadNftCollections(completion: @escaping NftCollectionCompletion)
}

final class NftCollectionServiceImpl: NftCollectionService {

    private let networkClient: NetworkClient
    private let storage: NftCollectionStorage

    init(networkClient: NetworkClient, storage: NftCollectionStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadNftCollections(completion: @escaping NftCollectionCompletion) {
        let request = NFTCollectionsRequest()
        networkClient.send(request: request, type: [NftCollection].self) { [weak storage] result in
            switch result {
            case .success(let collections):
                for collection in collections {
                    storage?.saveCollection(collection)
                    completion(.success(collections))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
