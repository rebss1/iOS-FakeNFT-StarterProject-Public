//
//  CartService.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 30.10.2024.
//

import Foundation

typealias CartCompletion = (Result<Cart, Error>) -> Void
typealias CartPutCompletion = (Result<Bool, Error>) -> Void

protocol CartService: AnyObject {
    func sendCartGetRequest(completion: @escaping CartCompletion)
    func sendCartPutRequest(id: String, nfts: [String], completion: @escaping CartPutCompletion)
}

final class CartServiceImpl: CartService {
    
    // MARK: - Private Properties
    
    private let networkClient: NetworkClient
    
    // MARK: - Initializers
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func sendCartGetRequest(completion: @escaping CartCompletion) {
        let request = CartGetRequest()
        networkClient.send(request: request, type: Cart.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let order):
                    completion(.success(order))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func sendCartPutRequest(id: String, nfts: [String], completion: @escaping CartPutCompletion) {
        let dto = CartDtoObject(nfts: nfts, id: id)
        let request = CartPutRequest(dto: dto)
        self.networkClient.send(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
