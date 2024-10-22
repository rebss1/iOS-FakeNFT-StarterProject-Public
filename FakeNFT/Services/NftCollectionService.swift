//
//  NftCollectionService.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 15.10.2024.
//

import Foundation

typealias NftCollectionCompletion = (Result<[NftCollection], Error>) -> Void

protocol NftCollectionService {
//    func loadNftCollection(id: String, completion: @escaping NftCollectionCompletion)
    func loadNftCollections(completion: @escaping NftCollectionCompletion)
}

final class NftCollectionServiceImpl: NftCollectionService {

    private let networkClient: NetworkClient
    private let storage: NftCollectionStorage

    init(networkClient: NetworkClient, storage: NftCollectionStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

//    func loadNftCollection(id: String, completion: @escaping NftCollectionCompletion) {
//        if let collection = storage.getCollection(with: id) {
//            completion(.success(collection))
//            return
//        }
//
//        let request = NFTCollectionRequest(id: id)
//        networkClient.send(request: request, type: NftCollection.self) { [weak storage] result in
//            switch result {
//            case .success(let collection):
//                storage?.saveCollection(collection)
//                completion(.success(collection))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
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
