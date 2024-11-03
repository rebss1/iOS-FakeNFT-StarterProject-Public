//
//  NftCollectionStorage.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 15.10.2024.
//

import Foundation

protocol NftCollectionStorage: AnyObject {
    func saveCollection(_ nft: NftCollection)
    func getCollection(with id: String) -> NftCollection?
}

final class NftCollectionStorageImpl: NftCollectionStorage {
    private var storage: [String: NftCollection] = [:]

    private let syncQueue = DispatchQueue(label: "sync-collection-queue")

    func saveCollection(_ nft: NftCollection) {
        syncQueue.async { [weak self] in
            self?.storage[nft.id] = nft
        }
    }

    func getCollection(with id: String) -> NftCollection? {
        syncQueue.sync {
            storage[id]
        }
    }
}
