//
//  CurrenciesService.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 02.11.2024.
//

import Foundation

typealias CurrencesGetCompletion = (Result<[Currency], Error>) -> Void

protocol CurrencesGetService {
    func sendCurrencesGetRequest(completion: @escaping CurrencesGetCompletion)
}

final class CurrencesGetServiceImpl: CurrencesGetService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func sendCurrencesGetRequest(completion: @escaping CurrencesGetCompletion) {
        let request = CurrencyRequest()
        networkClient.send(request: request, type: [Currency].self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let currencies):
                    completion(.success(currencies))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
