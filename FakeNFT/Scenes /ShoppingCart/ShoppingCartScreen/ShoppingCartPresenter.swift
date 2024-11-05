//
//  ShoppingCartPresenter.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 15.10.2024.
//

import UIKit

protocol ShoppingCartPresenter: AnyObject {
    func viewDidLoad()
    func setView(_ view: ShoppingCartView)
    func didTapSortButton()
    func didTapDeleteButton(on indexPath: IndexPath)
    func didTapPayButton()
    func deleteBLur()
    func deleteNft(id: String)
    func reloadData()
}

enum ShoppingCartPresenterState {
    case initial, loading, failed(Error), data([Nft])
}

enum ShoppingCartSortType {
    case name
    case raiting
    case price
}

final class ShoppingCartPresenterImpl {
    
    private var nfts: [Nft] = []
    private var sortedNfts: [Nft] = []
    private var nftsInCart: [String] = []
    private var id: String?
    private var nftPrice: Float = 0
    
    weak var view: ShoppingCartView?
    private var group = DispatchGroup()
    private let servicesAssembly: ServicesAssembly
    private let orderService: OrderService
    private let nftService: NftService
    private var state = ShoppingCartPresenterState.initial {
        didSet {
            stateDidChanged()
        }
    }
    private let defaultsManager = DefaultsManager()
    
    init(servicesAssembly: ServicesAssembly, nftService: NftService, orderService: OrderService) {
        self.servicesAssembly = servicesAssembly
        self.nftService = nftService
        self.orderService = orderService
    }
    
    private func stateDidChanged() {
        switch state {
            case .initial:
                assertionFailure("can't move to initial state")
            case .loading:
                view?.showLoading()
                group.enter()
                loadNftsInCart()
                group.leave()
                group.notify(queue: DispatchQueue.main) {
                    self.state = .data(self.nfts)
                }
            case .data(let order):
                view?.hideLoading()
                self.nfts = order
                let cellModels = nfts.map { nft in
                    ShoppingCartCellModel(name: nft.name,
                                          raiting: nft.rating,
                                          price: nft.price,
                                          image: nft.images[0]
                    )
                }
                countNft()
                view?.displayCells(cellModels, price: nftPrice, count: cellModels.count)
            case .failed(let error):
                let errorModel = makeErrorModel(error)
                view?.hideLoading()
                view?.showError(errorModel)
        }
    }
    
    func loadNfts() {
        let inputCollectionNfts = nftsInCart
        for nft in inputCollectionNfts {
            group.enter()
            nftService.loadNft(id: nft) { [weak self] result in
                guard let self = self else {
                    self?.group.leave()
                    return
                }
                switch result {
                    case .success(let nft):
                        nfts.append(nft)
                        if let sortType = defaultsManager.fetchObject(type: String.self, for: .sortType) {
                            if sortType == "name" {
                                sortCollections(by: .name)
                            } else if sortType == "raiting" {
                                sortCollections(by: .raiting)
                            } else if sortType == "price" {
                                sortCollections(by: .price)
                            }
                        }
                        self.state = .data(self.nfts)
                    case .failure(let error):
                        state = .failed(error)
                }
            }
            group.leave()
        }
    }
    
    func loadNftsInCart() {
        group.enter()
        orderService.sendOrderGetRequest() { [weak self] result in
            guard let self = self else {
                self?.group.leave()
                return
            }
            switch result {
                case .success(let cart):
                    nftsInCart = cart.nfts
                    id = cart.id
                    group.enter()
                    self.loadNfts()
                case .failure(let error):
                    state = .failed(error)
            }
        }
        group.leave()
    }
    
    func putNftsInCart(_ nftInCart: [String]) {
        guard let id = id else { return }
        group.enter()
        orderService.sendOrderPutRequest(id: id, nfts: nftInCart) { [weak self] result in
            guard let self = self else {
                self?.group.leave()
                return
            }
            switch result {
                case .success:
                    self.reloadData()
                case .failure(let error):
                    self.state = .failed(error)
            }
        }
        group.leave()
    }
    
    func countNft() {
        nftPrice = 0
        for nft in nfts {
            nftPrice += nft.price
        }
        nftPrice = Float(round(nftPrice * 100) / 100)
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
            self?.nfts = []
            self?.state = .loading
        }
    }
    
    func sortCollections(by type: ShoppingCartSortType) {
        switch type {
            case .name:
                defaultsManager.saveObject(value: "name", for: .sortType)
                sortedNfts = nfts.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
            case .raiting:
                defaultsManager.saveObject(value: "raiting", for: .sortType)
                sortedNfts = nfts.sorted { $0.rating > $1.rating }
            case .price:
                defaultsManager.saveObject(value: "price", for: .sortType)
                sortedNfts = nfts.sorted { $0.price > $1.price }
        }
        state = .data(sortedNfts)
    }
}

extension ShoppingCartPresenterImpl: ShoppingCartPresenter {
    
    func reloadData() {
        group = DispatchGroup()
        nfts = []
        sortedNfts = []
        nftsInCart = []
        nftPrice = 0
        self.state = .loading
    }
    
    func deleteNft(id: String) {

        nftsInCart.removeAll(where: { $0 == id })

        if nftsInCart.isEmpty {
            group.enter()
            putNftsInCart(["null"])
            group.leave()
            reloadData()
        } else {
            group.enter()
            putNftsInCart(nftsInCart)
            group.leave()
        }
    }
    
    func deleteBLur() {
        view?.deleteBlur()
    }
    
    func didTapDeleteButton(on indexPath: IndexPath) {
        let selectedNft = sortedNfts[indexPath.row]
        let deleteScreen = DeleteScreenViewController(image: selectedNft.images[0], id: selectedNft.id)
        deleteScreen.parentController = self
        deleteScreen.modalPresentationStyle = .overCurrentContext
        view?.presentCollection(on: deleteScreen)
    }
    
    func setView(_ view: any ShoppingCartView) {
        self.view = view
    }
    
    func viewDidLoad() {
        self.state = .loading
    }
    
    func didTapPayButton() {
        let assembler = PayScreenAssembly(servicesAssembler: servicesAssembly)
        guard let id = id, let view = view else { return }
        let input = PayScreenInput(id: id)
        let viewController = assembler.build(with: input, view: view)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.view?.presentCollection(on: navigationController)
    }
    
    func didTapSortButton() {
        let alertView = UIAlertController(
            title: NSLocalizedString("Cart.sort", comment: ""),
            message: nil,
            preferredStyle: .actionSheet
        )
        alertView.addAction(
            UIAlertAction(
                title: NSLocalizedString("Cart.byPrice", comment: ""),
                style: .default
            ) { [weak self] _ in
                self?.sortCollections(by: .price)
            }
        )
        alertView.addAction(
            UIAlertAction(
                title: NSLocalizedString("Cart.byRaiting", comment: ""),
                style: .default
            ) { [weak self] _ in
                self?.sortCollections(by: .raiting)
            }
        )
        alertView.addAction(
            UIAlertAction(
                title: NSLocalizedString("Cart.byName", comment: ""),
                style: .default
            ) { [weak self] _ in
                self?.sortCollections(by: .name)
            }
        )
        alertView.addAction(
            UIAlertAction(
                title: NSLocalizedString("Cart.close", comment: ""),
                style: .cancel
            )
        )
        view?.displayAlert(alertView)
    }
}
