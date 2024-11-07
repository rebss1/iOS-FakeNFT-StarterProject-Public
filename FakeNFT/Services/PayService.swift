//
//  PayService.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 05.11.2024.
//

import Foundation

typealias PayCompletion = (Result<Bool, Error>) -> Void

protocol PayService {
    func sendPayRequest(id: String, completion: @escaping PayCompletion)
}

final class PayServiceImpl: PayService {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func sendPayRequest(id: String, completion: @escaping PayCompletion) {
        let request = PayRequest(id: id)
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
