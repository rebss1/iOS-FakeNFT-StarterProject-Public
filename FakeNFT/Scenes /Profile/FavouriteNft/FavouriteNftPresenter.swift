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
    
    func loadNfts() {
        view?.refreshNfts(nfts: mockFavouriteNfts)
    }
}
