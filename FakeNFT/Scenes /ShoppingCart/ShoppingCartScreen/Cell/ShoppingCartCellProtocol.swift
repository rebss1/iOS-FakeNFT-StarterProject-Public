//
//  ShoppingCartCellProtocol.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 05.11.2024.
//

import Foundation

protocol ShoppingCartCellProtocol: AnyObject {
    func didTapDeleteButton(in cell: CartTableViewCell)
}
