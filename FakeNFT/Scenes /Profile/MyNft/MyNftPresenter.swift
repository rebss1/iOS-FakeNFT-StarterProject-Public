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
    
    func loadNfts() {
        view?.refreshNfts(nfts: mockMyNfts)
    }
}
