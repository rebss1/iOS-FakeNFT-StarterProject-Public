//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import Foundation

protocol ProfileService {

    func fetchProfile(id: String, completion: @escaping (Result<ProfileResponse, Error>) -> Void)

    func updateProfile(
        with profileDtoObject: ProfileDtoObject,
        completion: @escaping (Result<ProfileResponse, Error>) -> Void
    )
}

protocol ProfileServiceDelegate: AnyObject {

    func profileDidUpdate(profile: ProfileResponse)
}

final class ProfileServiceImpl: ProfileService {

    weak var delegate: ProfileServiceDelegate?

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchProfile(id: String, completion: @escaping (Result<ProfileResponse, Error>) -> Void) {
        networkClient.send(
            request: FetchProfileRequest(id: id),
            type: ProfileResponse.self,
            onResponse: completion
        )
    }
    
    func updateProfile(
        with profileDtoObject: ProfileDtoObject,
        completion: @escaping (Result<ProfileResponse, Error>) -> Void
    ) {
        let request = UpdateProfileRequest(dto: profileDtoObject)
        
        networkClient.send(request: request, type: ProfileResponse.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
//    func updateProfile(
//        with profileUpdate: ProfileUpdate,
//        completion: (@escaping (Result<ProfileResponse, Error>) -> Void)
//    ) {
//        let request = UpdateProfileRequest(profile: profileUpdate)
//        
//        print("[CHANGE LIKE] Request: \(profileUpdate.likes)")
//
//        networkClient.send(request: request, type: ProfileResponse.self) { result in
//            switch result {
//            case .success(let profile):
//                completion(.success(profile))
//
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
