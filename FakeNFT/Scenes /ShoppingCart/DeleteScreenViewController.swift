//
//  DeleteScreenViewController.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 16.10.2024.
//

import UIKit

final class DeleteScreenViewController: UIViewController {

    var parentController: ShoppingCartViewController?
    private var centerImage: UIImageView
    private let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("DeleteScreen.title", comment: "Вы уверены, что хотите удалить объект из корзины?")
        label.textColor = .blackCustom
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 2
        label.widthAnchor.constraint(equalToConstant: 180).isActive = true
        return label
    }()
    private let deleteButton = {
        let button = Button(title: NSLocalizedString("DeleteScreen.delete", comment: "Удалить"), style: .normal, color: .blackCustom) {
            // TODO: сделать удаление
        }
        button.setTitleColor(UIColor.redUniversal, for: .normal)
        button.layer.borderWidth = 0
        button.widthAnchor.constraint(equalToConstant: 127).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backButton = {
        let button = Button(title: NSLocalizedString("DeleteScreen.back", comment: "Вернуться"), style: .normal, color: .blackCustom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 0
        button.widthAnchor.constraint(equalToConstant: 127).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    init(image: UIImage) {
        self.centerImage = UIImageView(image: image)
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupImage()
        setupTitleLabel()
        setupDeleteButton()
        setupBackButton()
    }
    
    private func setupImage() {
        view.addSubview(centerImage)
        centerImage.translatesAutoresizingMaskIntoConstraints = false
        centerImage.widthAnchor.constraint(equalToConstant: 108).isActive = true
        centerImage.heightAnchor.constraint(equalToConstant: 108).isActive = true
        centerImage.layer.masksToBounds = true
        centerImage.layer.cornerRadius = 12
        centerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerImage.topAnchor.constraint(equalTo: view/*.safeAreaLayoutGuide*/.topAnchor, constant: 244).isActive = true
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: centerImage.leadingAnchor, constant: -36).isActive = true
        titleLabel.topAnchor.constraint(equalTo: centerImage.bottomAnchor, constant: 12).isActive = true
    }
    
    private func setupDeleteButton() {
        view.addSubview(deleteButton)
        deleteButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -41).isActive = true
        deleteButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 8).isActive = true
        backButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc private func backButtonTapped() {
        print("Back button tapped")
        parentController?.deleteBLur()
        dismiss(animated: true, completion: nil)
    }
}
