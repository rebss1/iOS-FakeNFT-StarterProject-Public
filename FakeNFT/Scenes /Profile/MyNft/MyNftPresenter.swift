//
//  MyNftPresenter.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import Foundation

protocol MyNFTVPresenterProtocol {

    var view: MyNFTViewControllerProtocol? { get set }

    func loadNfts()
    func changeLike(id: String, isLiked: Bool)
    func changeSort(_ sort: MyNFTSortType)
}

private enum MyNFTSortConstants {
    static let sortingPreferenceKey = "sortingPreference"
}

final class MyNFTPresenter: MyNFTVPresenterProtocol {

    weak var view: MyNFTViewControllerProtocol?

    private let profileNftService: ProfileNftService
    private let profileService: ProfileService
    
    private var sortService: ProfileSortServiceProtocol

    private let profile: ProfileResponse
    
    private var currentNftsIds: [String]
    private var likedNftsIds: [String]
    private var loadedNfts: [MyNFT] = []

    init(
        profile: ProfileResponse,
        view: MyNFTViewControllerProtocol,
        profileNftService: ProfileNftService,
        profileService: ProfileService,
        sortService: ProfileSortServiceProtocol
    ) {
        self.profile = profile
        self.view = view
        self.profileNftService = profileNftService
        self.profileService = profileService
        
        self.currentNftsIds = profile.nfts
        self.likedNftsIds = profile.likes
        self.sortService = sortService
    }
    
    func loadNfts() {
        loadedNfts = []
        
        if currentNftsIds.isEmpty {
            view?.refreshNfts(nfts: loadedNfts)
        } else {
            
            view?.setLoader(visible: true)
            
            let dispatchGroup = DispatchGroup()
            
            profile.nfts.forEach { id in
                dispatchGroup.enter()
                profileNftService.loadNft(id: id) { [weak self] result in
                    defer { dispatchGroup.leave() }
                    
                    guard let self else { return }
                    
                    switch result {
                    case .success(let nft):
                        self.loadedNfts.append(
                            MyNFT(nft, isLiked: nft.isLiked(self.likedNftsIds))
                        )
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.view?.showError(self.checkError(error))
                            self.view?.setLoader(visible: false)

                        }
                        print("Error loading NFT \(id): \(error)")
                    }
                }
                
                dispatchGroup.notify(queue: .main) { [weak self] in
                    guard let self else { return }
                    
                    self.refreshNftsView()
                    self.view?.setLoader(visible: false)
                }
            }
        }
    }

    func changeLike(id: String, isLiked: Bool) {
        var newLikes: [String] = likedNftsIds
        
        if isLiked {
            newLikes.append(id)
        } else {
            newLikes = newLikes.filter { $0 != id }
        }

        let profileUpdateDto = ProfileDtoObject(
            name: profile.name,
            avatar: nil,
            description: profile.description,
            website: profile.website?.absoluteString ?? "",
            likes: newLikes
        )
        
        profileService.updateProfile(with: profileUpdateDto) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                if isLiked {
                    self.likedNftsIds.append(id)

                } else {
                    self.likedNftsIds = self.likedNftsIds.filter { $0 != id }
                }
                
                self.loadNfts()
                
            case .failure(let failure):
                print("Change like failed: \(failure)")
            }
            
        }
    }
    
    func changeSort(_ sort: MyNFTSortType) {
        sortService.sort = sort
        
        refreshNftsView()
    }
    
    private func refreshNftsView() {
        let sortedNfts: [MyNFT]
        switch sortService.sort {
        case .name:
            sortedNfts = self.loadedNfts.sorted(by: { $0.name < $1.name } )
        case .rating:
            sortedNfts = self.loadedNfts.sorted(by: { $0.rating > $1.rating } )
        case .price:
            sortedNfts = self.loadedNfts.sorted(by: { $0.price > $1.price } )
        }
        
        self.view?.refreshNfts(nfts: sortedNfts)
    }
    
    private func checkError(_ error: Error) -> ErrorModel {
        let message: String
        switch error {
        case is NetworkClientError:
            message = NSLocalizedString("Error.network", comment: "")
        default:
            message = NSLocalizedString("Error.unknown", comment: "")
        }

        let actionText = NSLocalizedString("Error.repeat", comment: "")

        return ErrorModel(message: message, actionText: actionText) { [weak self] in
            self?.loadNfts()
        }
    }
}
