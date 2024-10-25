//
//  NftCollectionHeader.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 22.10.2024.
//

import UIKit
import Kingfisher

final class NftCollectionHeader: UICollectionViewCell, ReuseIdentifying {
    
    // MARK: - Constants

    static let identifier = "NftCollectionHeader"
    
    // MARK: - UIViews

    private lazy var nftCollectionCover: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.font = .headline3
        label.textColor = .blackCustom
        return label
    }()
    
    private lazy var collectionAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.text = NSLocalizedString("Collection.author", comment: "")
        label.textColor = .blackCustom
        return label
    }()
    
    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .blueUniversal
        return label
    }()
    
    private lazy var collectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .blackCustom
        label.numberOfLines = 10
        return label
    }()
    
    private lazy var authorNameStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .leading
        return stack
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public Functions
    
    func configure(with cellModel: NftCollectionHeaderModel) {
        self.nftCollectionCover.kf.setImage(with: cellModel.cover)
        self.collectionNameLabel.text = cellModel.name
        self.authorNameLabel.text = cellModel.author
        self.collectionDescriptionLabel.text = cellModel.description
    }
    
    // MARK: - Private Functions
    
    private func setUp() {
        contentView.addSubviews([nftCollectionCover, collectionNameLabel, collectionAuthorLabel, authorNameLabel, collectionDescriptionLabel])
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nftCollectionCover.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            nftCollectionCover.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            nftCollectionCover.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            nftCollectionCover.heightAnchor.constraint(equalToConstant: 310),
            
            collectionNameLabel.topAnchor.constraint(equalTo: nftCollectionCover.bottomAnchor, constant: 16),
            collectionNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            collectionNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            collectionNameLabel.heightAnchor.constraint(equalToConstant: 28),
            
            collectionAuthorLabel.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 13),
            collectionAuthorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            collectionAuthorLabel.heightAnchor.constraint(equalToConstant: 18),
            
            authorNameLabel.centerYAnchor.constraint(equalTo: collectionAuthorLabel.centerYAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: collectionAuthorLabel.trailingAnchor, constant: 4),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 28),
            
            collectionDescriptionLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor),
            collectionDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            collectionDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
}
