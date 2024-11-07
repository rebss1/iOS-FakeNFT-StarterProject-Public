//
//  SuccessViewController.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 06.11.2024.
//

import UIKit

protocol SuccessView: AnyObject {
    func displayCells(_ cellModels: [PayScreenCellModel])
    func displayAlert(_ alert: UIAlertController)
    func present(on viewController: UIViewController)
}

final class SuccessViewController: UIViewController {
        
    private lazy var button: UIButton = {
        let button = Button(title: NSLocalizedString("Success.button", comment: "Вернуться в каталог"), style: .normal, color: .blackCustom) { [weak self] in
            self?.dismiss(animated: true)
        }
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Success.label", comment: "Успех! Оплата прошла, поздравляем с покупкой!")
        label.textColor = .blackCustom
        label.numberOfLines = 2
        label.font = .headline3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let image = {
        let image = UIImageView(image: UIImage(named: "successScreenImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteCustom
        setupUI()
    }
    
    private func setupUI() {
        setupImage()
        setupBackButton()
        setupLabel()
    }
    private func setupLabel() {
        view.addSubview(titleText)
        
        titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
        titleText.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true
        titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
    }
    private func setupBackButton() {
        view.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupImage() {
        view.addSubview(image)
        image.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 278).isActive = true
        image.heightAnchor.constraint(equalToConstant: 278).isActive = true
    }
}
