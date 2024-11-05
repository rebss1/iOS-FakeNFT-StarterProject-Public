//
//  PayScreenPresenter.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 05.11.2024.
//

import UIKit

protocol PayScreenPresenter: AnyObject {
    func viewDidLoad()
    func setView(_ view: PayScreenView)
    func didTapWebViewButton()
    func didSelectCurrency(on indexPath: IndexPath)
    func didTapPayButton()
}

enum PayScreenPresenterState {
    case initial, loading, failed(Error), data([Currency])
}

final class PayScreenPresenterImpl {
    private var currencies: [Currency] = []
    private var selectedCurrency: String?
    private var CartId: PayScreenInput
    weak var view: PayScreenView?
    var presentView: ShoppingCartView?
    private var group = DispatchGroup()
    private let servicesAssembly: ServicesAssembly
    private let orderService: OrderService
    private let payService: PayService
    private let currenciesService: CurrencesGetService
    private var state = PayScreenPresenterState.initial {
        didSet {
            stateDidChanged()
        }
    }

    init(view: ShoppingCartView, id: PayScreenInput, servicesAssembly: ServicesAssembly, orderService: OrderService, currenciesService: CurrencesGetService, payService: PayService) {
        self.presentView = view
        self.CartId = id
        self.servicesAssembly = servicesAssembly
        self.orderService = orderService
        self.currenciesService = currenciesService
        self.payService = payService
    }

    private func stateDidChanged() {
        switch state {
            case .initial:
                assertionFailure("can't move to initial state")
            case .loading:
                view?.showLoading()
                group.enter()
                loadCurrencies()
                group.leave()
                group.notify(queue: DispatchQueue.main) {
                    self.state = .data(self.currencies)
                }
            case .data(let currencies):
                view?.hideLoading()
                self.currencies = currencies
                let cellModels = currencies.map { currency in
                    PayScreenCellModel(title: currency.title,
                                       name: currency.name,
                                       image: currency.image)
                }
                view?.displayCells(cellModels)
            case .failed(let error):
                let error = makeErrorModelWithCancel(error)
                view?.hideLoading()
                view?.showErrorWithCancel(error)
        }
    }
    
    func loadCurrencies() {
        group.enter()
        currenciesService.sendCurrencesGetRequest() { [weak self] result in
            guard let self = self else {
                self?.group.leave()
                return
            }
            switch result {
                case .success(let currency):
                    currencies = currency
                    self.state = .data(self.currencies)
                case .failure(let error):
                    state = .failed(error)
            }
            self.group.leave()
        }
    }
    
    func tryToPay() {
        group.enter()
        payService.sendPayRequest(id: selectedCurrency ?? "") { [weak self] result in
            guard let self = self else {
                self?.group.leave()
                return
            }
            switch result {
                case .success:
                    putNftsInCart()
                case .failure(let error):
                    state = .failed(error)
            }
            self.group.leave()
        }
    }
    
    func putNftsInCart() {
        group.enter()
        orderService.sendOrderPutRequest(id: CartId.id, nfts: ["null"]) { [weak self] result in
            guard let self = self else {
                self?.group.leave()
                return
            }
            switch result {
                case .success:
                    self.view?.dismissScreen()
                    let successScreen = SuccessViewController()
                    successScreen.modalPresentationStyle = .fullScreen
                    presentView?.presentCollection(on: successScreen)
                    presentView?.reloadData()
                case .failure(let error):
                    self.state = .failed(error)
            }
            self.group.leave()
        }
    }
    
    func makeErrorModelWithCancel(_ error: Error) -> ErrorModelWithCancel {
        let message: String
        switch error {
            case is NetworkClientError:
                message = NSLocalizedString("Error.pay", comment: "")
            default:
                message = NSLocalizedString("Error.unknown", comment: "")
        }
        
        let actionText = NSLocalizedString("Error.repeat", comment: "")
        return ErrorModelWithCancel(message: message, actionText: actionText) { [weak self] in
            self?.tryToPay()
        }
    }
}
extension PayScreenPresenterImpl: PayScreenPresenter {
    func didSelectCurrency(on indexPath: IndexPath) {
        selectedCurrency = "\(indexPath.row)"
    }
    
    func didTapPayButton() {
        tryToPay()
    }
    
    func setView(_ view: PayScreenView) {
        self.view = view
    }
    
    func didTapWebViewButton() {
        let webScreen = WebViewScreenViewController()
        let navController = webScreen.wrapWithNavigationController()
        navController.modalPresentationStyle = .overCurrentContext
        view?.present(on: navController)
    }
    
    func viewDidLoad() {
        self.state = .loading
        
    }
}

        
