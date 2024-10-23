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
}

final class MyNFTPresenter: MyNFTVPresenterProtocol {
    
    weak var view: MyNFTViewControllerProtocol?
    
    private let profileNftService: ProfileNftService
    
    private let myNftsIds: [String]
    private let likedNftsIds: [String]
    
    private var loadedNfts: [MyNFT] = []
    
    init(
        myNftsIds: [String],
        likedNftsIds: [String],
        view: MyNFTViewControllerProtocol,
        profileNftService: ProfileNftService
    ) {
        self.myNftsIds = myNftsIds
        self.likedNftsIds = likedNftsIds
        self.view = view
        self.profileNftService = profileNftService
    }
    
    func loadNfts() {
        if myNftsIds.isEmpty {
            view?.refreshNfts(nfts: loadedNfts)
        } else {
            
            view?.setLoader(visible: true)
            
            let dispatchGroup = DispatchGroup()
            
            myNftsIds.forEach { id in
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
                    
                    self.view?.setLoader(visible: false)
                    self.view?.refreshNfts(nfts: self.loadedNfts)
                }
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
