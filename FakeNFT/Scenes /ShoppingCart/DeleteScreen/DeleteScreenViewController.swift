//
//  DeleteScreenViewController.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 16.10.2024.
//

import UIKit
import Kingfisher

final class DeleteScreenViewController: UIViewController {

    var id: String
    weak var parentController: ShoppingCartPresenter?
    private var centerImage: UIImageView
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("DeleteScreen.title", comment: "Вы уверены, что хотите удалить объект из корзины?")
        label.textColor = .blackCustom
        label.textAlignment = .center
        label.font = .caption2
        label.numberOfLines = 2
        return label
    }()
    private lazy var deleteButton: UIButton = {
        let button = Button(title: NSLocalizedString("DeleteScreen.delete", comment: "Удалить"), style: .normal, color: .blackCustom) { [weak self] in
            self?.parentController?.deleteNft(id: self?.id ?? "")
            self?.parentController?.deleteBLur()
            self?.dismiss(animated: true, completion: nil)
        }
        button.setTitleColor(UIColor.redUniversal, for: .normal)
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var backButton: UIButton = {
        let button = Button(title: NSLocalizedString("DeleteScreen.back", comment: "Вернуться"), style: .normal, color: .blackCustom){ [weak self] in
            self?.parentController?.deleteBLur()
            self?.dismiss(animated: true, completion: nil)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 0
        return button
    }()
    
    init(image: URL, id: String) {
        self.id = id
        self.centerImage = UIImageView()
        self.centerImage.kf.setImage(with: image)
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
        titleLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    private func setupDeleteButton() {
        view.addSubview(deleteButton)
        deleteButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -41).isActive = true
        deleteButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 127).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 8).isActive = true
        backButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 127).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

    }
}
