//
//  CatalogPresenter.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 15.10.2024.
//

import Foundation
import UIKit

enum CatalogPresenterState {
    case initial, loading, failed(Error), data([NftCollection])
}

protocol CatalogPresenter: AnyObject {
    func viewDidLoad()
    func setView(_ view: CatalogView)
    func didTapSortButton()
    func didSelectCollection(with index: Int)
}

final class CatalogPresenterImpl {
    
    //MARK: - Private properties
    
    private var sortedCollections: [NftCollection] = []
    private var collections: [NftCollection] = []
    
    weak var view: CatalogView?
    private let services: ServicesAssembly
    private var state = CatalogPresenterState.initial {
        didSet {
            stateDidChanged()
        }
    }
    private let defaultsManager = DefaultsManager()
    
    //MARK: - Initializers
    
    init(servicesAssembly: ServicesAssembly) {
        self.services = servicesAssembly
    }
}

    // MARK: - Private Methods
    
private extension CatalogPresenterImpl {
    
    func stateDidChanged() {
        switch state {
        case .initial:
            assertionFailure("can't move to initial state")
        case .loading:
            view?.showLoading()
            loadCollections()
        case .data(let collections):
            view?.hideLoading()
            self.collections = collections
            let cellModels = collections.map {
                CatalogCellModel(title: $0.name,
                                 size: $0.nfts.count,
                                 cover: $0.cover)
            }
            view?.displayCells(cellModels)
        case .failed(let error):
            let errorModel = makeErrorModel(error)
            view?.hideLoading()
            view?.showError(errorModel)
        }
    }
    
    func loadCollections() {
        services.nftCollectionService.loadNftCollections() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let collections):
                state = .data(collections)
                if let sortType = defaultsManager.fetchObject(type: String.self, for: .sortType) {
                    if sortType == "name" {
                        sortCollections(by: .name)
                    } else if sortType == "quantity" {
                        sortCollections(by: .nftsQuantity)
                    }
                    break
                }
            case .failure(let error):
                state = .failed(error)
            }
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
    
    func sortCollections(by type: CatalogSortType) {
        switch type {
        case .name:
            defaultsManager.saveObject(value: "name", for: .sortType)
            sortedCollections = collections.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .nftsQuantity:
            defaultsManager.saveObject(value: "quantity", for: .sortType)
            sortedCollections = collections.sorted { $0.nfts.count > $1.nfts.count }
        }
        state = .data(sortedCollections)
    }
}

extension CatalogPresenterImpl: CatalogPresenter {
    
    func didSelectCollection(with index: Int) {
        let assembler = NftCollectionAssembly(servicesAssembler: services)
        let collection: NftCollection
        if sortedCollections.isEmpty {
            collection = collections[index]
        } else {
            collection = sortedCollections[index]
        }
        let input = NftCollectionInput(collection: collection)
        let viewController = assembler.build(with: input)
        viewController.modalPresentationStyle = .fullScreen
        self.view?.presentCollection(on: viewController)
    }
    
    func didTapSortButton() {
        let alertView = UIAlertController(
            title: NSLocalizedString("Sort.title", comment: ""),
            message: nil,
            preferredStyle: .actionSheet
        )
        alertView.addAction(
            UIAlertAction(
                title: NSLocalizedString("Sort.byName", comment: ""),
                style: .default
            ) { [weak self] _ in
                self?.sortCollections(by: .name)
            }
        )
        alertView.addAction(
            UIAlertAction(
                title: NSLocalizedString("Sort.byCount", comment: ""),
                style: .default
            ) { [weak self] _ in
                self?.sortCollections(by: .nftsQuantity)
            }
        )
        alertView.addAction(
            UIAlertAction(
                title: NSLocalizedString("Sort.cancel", comment: ""),
                style: .cancel
            )
        )
        view?.displayAlert(alertView)
    }
    
    func setView(_ view: any CatalogView) {
        self.view = view
    }

    func viewDidLoad() {
        self.state = .loading
    }
}
