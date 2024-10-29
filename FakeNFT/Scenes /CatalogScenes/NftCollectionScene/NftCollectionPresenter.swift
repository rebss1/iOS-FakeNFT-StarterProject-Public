//
//  NftCollectionPresenter.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 23.10.2024.
//

import Foundation

enum NftCollectionPresenterState {
    case initial
    case loading
    case failed(Error)
    case data([Nft])
}

protocol NftCollectionPresenter {
    func viewDidLoad()
    func didTapLikeButton(on indexPath: IndexPath)
    func didTapCartButton()
}

final class NftCollectionPresenterImpl {
    
    //MARK: - Public properties
    
    weak var view: NftCollectionView?
    
    //MARK: - Private properties
    
    private var group = DispatchGroup()
    private var nfts: [Nft] = []
    private var likedNfts: [String] = []
    private let input: NftCollectionInput
    private let nftService: NftService
    private let likedNftService: LikedNftsService
    private var state = NftCollectionPresenterState.initial {
        didSet {
            stateDidChanged()
        }
    }
    
    //MARK: - Initializers
    
    init(input: NftCollectionInput, nftService: NftService, likedNftService: LikedNftsService) {
        self.input = input
        self.nftService = nftService
        self.likedNftService = likedNftService
    }
}

// MARK: - Private Methods

private extension NftCollectionPresenterImpl {
    
    func stateDidChanged() {
        switch state {
        case .initial:
            assertionFailure("can't move to initial state")
        case .loading:
            view?.showLoading()
            let collection = input.collection
            let headerModel = NftCollectionHeaderModel(
                cover: collection.cover,
                name: collection.name,
                author: collection.author,
                description: collection.description
            )
            view?.displayHeader(headerModel)
            loadNfts()
        case .data(let nfts):
            view?.hideLoading()
            let cellModels = nfts.map { nft in
                NftCollectionCellModel(
                    name: nft.name,
                    image: nft.images[0],
                    rating: nft.rating,
                    price: nft.price,
                    isLiked: likedNfts.contains(where: { $0 == nft.id}),
                    inCart: true
                )
            }
            view?.displayCells(cellModels)
        case .failed(let error):
            let errorModel = makeErrorModel(error)
            view?.hideLoading()
            view?.showError(errorModel)
        }
    }
    
    func loadNfts() {
        let inputCollectionNfts = input.collection.nfts
        for nft in inputCollectionNfts {
            group.enter()
            nftService.loadNft(id: nft.absoluteString) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let nft):
                    nfts.append(nft)
                    group.leave()
                case .failure(let error):
                    state = .failed(error)
                    break
                }
            }
        }
        group.notify(queue: DispatchQueue.main) {
            self.state = .data(self.nfts)
        }
    }
    
    func makeErrorModel(_ error: Error) -> ErrorModel {
        let message: String
        switch error {
        case is NetworkClientError:
            message = NSLocalizedString("Error.network", comment: "")
        default:
            message = NSLocalizedString("Error.unknown", comment: "")
        }
        
        let actionText = NSLocalizedString("Error.repeat", comment: "")
        return ErrorModel(message: message, actionText: actionText) { [weak self] in
            self?.state = .loading
        }
    }
    
    func putLikedNfts(_ likedNfts: [String]) {
        likedNftService.sendLikedNftsPutRequest(likedNfts: likedNfts) { [weak self] result in
            switch result {
            case .success(_):
//                self?.likedNfts = nfts.asArray()
                if let nfts = self?.nfts {
                    self?.state = .data(nfts)
                }
            case .failure(let error):
                self?.state = .failed(error)
                break
            }
        }
    }
}

extension NftCollectionPresenterImpl: NftCollectionPresenter {
    
    func didTapLikeButton(on indexPath: IndexPath) {
        let nft = nfts[indexPath.row].id
        if likedNfts.contains(where: { $0 == nft }) {
            likedNfts.removeAll(where: {
                $0 == nft
            })
        } else {
            likedNfts.append(nft)
        }
        if likedNfts.isEmpty {
            putLikedNfts(["null"])
        } else {
            putLikedNfts(likedNfts)
        }
    }
    
    func didTapCartButton() {
        
    }
    
    func viewDidLoad() {
        state = .loading
    }
}
