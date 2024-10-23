//
//  FavoriteNftPresenter.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import Foundation

protocol FavouriteNFTPresenterProtocol {
    
    var view: FavouriteNFTViewControllerProtocol? { get set }
    
    func loadNfts()
}

final class FavouriteNFTPresenter: FavouriteNFTPresenterProtocol {
    
    weak var view: FavouriteNFTViewControllerProtocol?
    
    private let profileNftService: ProfileNftService
    
    private let favouriteNftsIds: [String]
    
    private var loadedNfts: [FavouriteNFT] = []
    
    init(
        favouriteNftsIds: [String],
        view: FavouriteNFTViewControllerProtocol,
        profileNftService: ProfileNftService
    ) {
        self.view = view
        self.profileNftService = profileNftService
        self.favouriteNftsIds = favouriteNftsIds
    }
    
    func loadNfts() {
        if favouriteNftsIds.isEmpty {
            view?.refreshNfts(nfts: loadedNfts)
        } else {
            view?.setLoader(visible: true)
            
            let dispatchGroup = DispatchGroup()
            
            favouriteNftsIds.forEach { id in
                dispatchGroup.enter()
                profileNftService.loadNft(id: id) { [weak self] result in
                    defer { dispatchGroup.leave() }
                    
                    guard let self else { return }
                    
                    switch result {
                    case .success(let nft):
                        self.loadedNfts.append(FavouriteNFT(nft, isLiked: nft.isLiked(self.favouriteNftsIds)))
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.view?.showError(self.checkError(error))
                            self.view?.setLoader(visible: false)

                        }
                        print("Error loading NFT \(id): \(error)")
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) { [weak self] in
                guard let self else { return }
                
                self.view?.setLoader(visible: false)
                self.view?.refreshNfts(nfts: self.loadedNfts)
            }
        }
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

