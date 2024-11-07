//
//  OrderService.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 03.11.2024.
//

import Foundation

typealias OrderGetCompletion = (Result<Order, Error>) -> Void
typealias OrderPutCompletion = (Result<Bool, Error>) -> Void

protocol OrderService: AnyObject {
    func sendOrderGetRequest(completion: @escaping OrderGetCompletion)
    func sendOrderPutRequest(id: String, nfts: [String], completion: @escaping OrderPutCompletion)
}

final class OrderServiceImpl: OrderService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func sendOrderGetRequest(completion: @escaping OrderGetCompletion) {
        let request = OrderGetRequest()
        networkClient.send(request: request, type: Order.self) { result in
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
    
    func sendOrderPutRequest(id: String, nfts: [String], completion: @escaping OrderPutCompletion) {
        let dto = OrderDtoObject(nfts: nfts, id: id)
        let request = OrderPutRequest(dto: dto)
        networkClient.send(request: request) { result in
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
