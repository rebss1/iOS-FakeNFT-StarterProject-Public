//
//  NftCollectionAssembly.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 23.10.2024.
//

import UIKit

final class NftCollectionAssembly {
    
    private let servicesAssembler: ServicesAssembly

    init(servicesAssembler: ServicesAssembly) {
        self.servicesAssembler = servicesAssembler
    }

    public func build(with input: NftCollectionInput) -> UIViewController {
        let presenter = NftCollectionPresenterImpl(
            input: input,
            nftService: servicesAssembler.nftService,
            likedNftService: servicesAssembler.likedNftsService,
            cartService: servicesAssembler.cartService
        )
        let viewController = NftCollectionViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
