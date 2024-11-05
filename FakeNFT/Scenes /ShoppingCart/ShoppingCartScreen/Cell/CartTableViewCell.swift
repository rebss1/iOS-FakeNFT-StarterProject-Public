//
//  CartTableViewCell.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 15.10.2024.
//

import UIKit
import Kingfisher


final class CartTableViewCell: UITableViewCell, ReuseIdentifying {
    
    static let defaultReuseIdentifier = "CustomTableCell"
    weak var parentController: ShoppingCartViewController?
    weak var delegate: ShoppingCartCellProtocol?
    private let NFTImage = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    private let raitingImage = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let nameLable = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blackCustom
        label.font = .bodyBold
        return label
    }()
    private let priceLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Cart.price", comment: "Цена")
        label.textColor = .blackCustom
        label.font = .caption2
        return label
    }()
    private let countPriceLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blackCustom
        label.font = .bodyBold
        return label
    }()
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cartDelete"), for: .normal)
        button.tintColor = UIColor.blackCustom
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
        deleteButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc private func deleteButtonTapped() {
        delegate?.didTapDeleteButton(in: self)
    }
    
    func changeCell(with cellModel: ShoppingCartCellModel){
        nameLable.text = cellModel.name
        NFTImage.kf.setImage(with: cellModel.image)
        countPriceLabel.text = "\(cellModel.price) ETH"
        if cellModel.raiting == 0 {
            raitingImage.image = UIImage(named: "zeroStars")
        } else if cellModel.raiting == 1 {
            raitingImage.image = UIImage(named: "oneStars")
        } else if cellModel.raiting == 2 {
            raitingImage.image = UIImage(named: "twoStars")
        } else if cellModel.raiting == 3 {
            raitingImage.image = UIImage(named: "threeStars")
        } else if cellModel.raiting == 4 {
            raitingImage.image = UIImage(named: "fourStars")
        } else if cellModel.raiting == 5 {
            raitingImage.image = UIImage(named: "fiveStars")
        }
    }
}
