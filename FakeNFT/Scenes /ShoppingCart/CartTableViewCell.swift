//
//  CartTableViewCell.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 15.10.2024.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    var parentController: ShoppingCartViewController?
    let NFTImage = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        image.image = UIImage(named: "shiba")// Mock данные, в дальшейшем заменятся на данные с сервера
        return image
    }()
    let raitingImage = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "fiveStars") // Mock данные, в дальшейшем заменятся на данные с сервера
        return image
    }()
    let nameLable = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.textColor = .blackCustom
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    let priceLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Cart.price", comment: "Цена")
        label.textColor = .blackCustom
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let countPriceLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 ETH"
        label.textColor = .blackCustom
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cartDelete"), for: .normal)
        button.tintColor = UIColor.blackCustom
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .whiteCustom
        selectionStyle = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        setupNFTImage()
        setupRaitingImage()
        setupNameLable()
        setupPriceLable()
        setupCountPriceLabel()
        setupDeleteButton()
    }
    
    private func setupNFTImage() {
        contentView.addSubview(NFTImage)
        NFTImage.widthAnchor.constraint(equalToConstant: 108).isActive = true
        NFTImage.heightAnchor.constraint(equalToConstant: 108).isActive = true
        NFTImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        NFTImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
    }
    private func setupRaitingImage() {
        contentView.addSubview(raitingImage)
        raitingImage.heightAnchor.constraint(equalToConstant: 12).isActive = true
        raitingImage.leadingAnchor.constraint(equalTo: NFTImage.trailingAnchor, constant: 20).isActive = true
        raitingImage.topAnchor.constraint(equalTo: NFTImage.topAnchor, constant: 34).isActive = true
    }
    
    private func setupNameLable() {
        contentView.addSubview(nameLable)
        nameLable.leadingAnchor.constraint(equalTo: NFTImage.trailingAnchor, constant: 20).isActive = true
        nameLable.topAnchor.constraint(equalTo: NFTImage.topAnchor, constant: 8).isActive = true
    }
    
    private func setupPriceLable() {
        contentView.addSubview(priceLabel)
        priceLabel.leadingAnchor.constraint(equalTo: NFTImage.trailingAnchor, constant: 20).isActive = true
        priceLabel.topAnchor.constraint(equalTo: NFTImage.topAnchor, constant: 58).isActive = true
    }
    
    private func setupCountPriceLabel() {
        contentView.addSubview(countPriceLabel)
        countPriceLabel.leadingAnchor.constraint(equalTo: NFTImage.trailingAnchor, constant: 20).isActive = true
        countPriceLabel.topAnchor.constraint(equalTo: NFTImage.topAnchor, constant: 78).isActive = true
    }
    
    private func setupDeleteButton() {
        contentView.addSubview(deleteButton)
        deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46).isActive = true
    }
    
    @objc private func deleteButtonTapped() {
        parentController?.presentScreen(image: NFTImage.image ?? UIImage())
    }
    
    private func changeCell(){
        //TODO: Сделать обработку данных с сервера
    }
}
