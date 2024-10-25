//
//  NftCollectionCell.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 22.10.2024.
//

import UIKit
import Kingfisher

protocol NftCollectionCellDelegate: AnyObject {
    func didTapLikeButton(in cell: NftCollectionCell)
    func didTapCartButton()
}

final class NftCollectionCell: UICollectionViewCell, ReuseIdentifying {
    
    // MARK: - Constants

    static var defaultReuseIdentifier = "NftCollectionCell"
    
    // MARK: - Public Properties
    
    weak var delegate: NftCollectionCellDelegate?
    
    // MARK: - UIViews
    
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self,
                         action: #selector(didTapLikeButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self,
                         action: #selector(didTapCartButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold
        label.textColor = .blackCustom
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = .blackCustom
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .fill
        return stack
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setUp()
    }
    
    // MARK: - Public Methods

    func configure(with cellModel: NftCollectionCellModel) {
        self.nameLabel.text = cellModel.name
        self.nftImageView.kf.setImage(with: cellModel.image)
        self.priceLabel.text = "\(cellModel.price) ETH"
        self.ratingImageView.image = UIImage(named: "stars\(cellModel.rating)")
        self.likeButton.setBackgroundImage(UIImage(named: cellModel.isLiked ? "likeActive" : "likeNoActive"), for: .normal)
        self.cartButton.setBackgroundImage(UIImage(named: cellModel.inCart ? "inCart" : "notInCart"), for: .normal)
    }
    
    // MARK: - Private Methods
    
    private func setUp() {
        labelStack.addArrangedSubview(nameLabel)
        labelStack.addArrangedSubview(priceLabel)
        bottomStack.addArrangedSubview(labelStack)
        bottomStack.addArrangedSubview(cartButton)
        contentView.addSubviews([nftImageView, likeButton, ratingImageView, bottomStack])
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nftImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            nftImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            nftImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            likeButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            
            ratingImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            ratingImageView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 8),
            ratingImageView.heightAnchor.constraint(equalToConstant: 12),
            ratingImageView.widthAnchor.constraint(equalToConstant: 68),
            
            bottomStack.topAnchor.constraint(equalTo: ratingImageView.bottomAnchor, constant: 4),
            bottomStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            bottomStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            bottomStack.heightAnchor.constraint(equalToConstant: 40),
            bottomStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
            cartButton.heightAnchor.constraint(equalToConstant: 40),
            cartButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc
    private func didTapLikeButton() {
        delegate?.didTapLikeButton(in: self)
    }
    
    @objc
    private func didTapCartButton() {
        delegate?.didTapCartButton()
    }
}
