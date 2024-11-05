//
//  CurrenciesPutRequest.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 03.11.2024.
//

import Foundation

struct CurrenciesGetRequest: NetworkRequest {
   var endpoint: URL? {
       URL(string: "\(RequestConstants.baseURL)/api/v1/currencies")
   }
   var httpMethod: HttpMethod = .put
   var dto: Dto?
}

struct CurrenciesDtoObject: Dto {
   let param1: String
   let param2: String

    enum CodingKeys: String, CodingKey {
        case param1 = "param_1" //имя поля в запросе будет param_1
        case param2 //имя поля в запросе будет param_2
    }

    func asDictionary() -> [String : String] {
        [
            CodingKeys.param1.rawValue: param1,
            CodingKeys.param2.rawValue: param2
        ]
    }
}

struct CurrenciesPutResponse: Decodable {
    let name: String
    let devices: [String]
}
