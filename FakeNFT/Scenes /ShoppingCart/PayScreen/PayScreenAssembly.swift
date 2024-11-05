//
//  PayScreenAssembly.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 05.11.2024.
//

import UIKit

public final class PayScreenAssembly {

    private let servicesAssembler: ServicesAssembly

    init(servicesAssembler: ServicesAssembly) {
        self.servicesAssembler = servicesAssembler
    }

    func build(with input: PayScreenInput, view: ShoppingCartView) -> UIViewController {
        let presenter = PayScreenPresenterImpl(view: view, id: input, servicesAssembly: servicesAssembler, orderService: servicesAssembler.orderService, currenciesService: servicesAssembler.currencyService, payService: servicesAssembler.payService)
        let viewController = PayScreenViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
