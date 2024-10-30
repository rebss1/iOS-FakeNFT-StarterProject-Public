//
//  NftCollectionHeader.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 22.10.2024.
//

import UIKit
import Kingfisher

protocol NftCollectionHeaderDelegate: AnyObject {
    func didTapAuthorButton(in cell: NftCollectionHeader)
}

final class NftCollectionHeader: UICollectionViewCell, ReuseIdentifying {
    
    // MARK: - Constants
    
    static let identifier = "NftCollectionHeader"
    
    // MARK: - Public Properties
    
    weak var delegate: NftCollectionHeaderDelegate?
    
    // MARK: - UI
    
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
    
    private lazy var authorNameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blueUniversal, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .caption1
        button.addTarget(self,
                         action: #selector(didTapAuthorButton),
                         for: .touchUpInside)
        return button
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
    
    // MARK: - Public Methods

    func configure(with cellModel: NftCollectionHeaderModel) {
        nftCollectionCover.kf.setImage(with: cellModel.cover)
        collectionNameLabel.text = cellModel.name
        authorNameButton.setTitle(cellModel.author, for: .normal)
        collectionDescriptionLabel.text = cellModel.description
    }
}
    
    // MARK: - Private Functions
    
private extension NftCollectionHeader {
    
     func setUp() {
        contentView.addSubviews([nftCollectionCover, collectionNameLabel, collectionAuthorLabel, authorNameButton, collectionDescriptionLabel])
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nftCollectionCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftCollectionCover.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftCollectionCover.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftCollectionCover.heightAnchor.constraint(equalToConstant: 310),
            
            collectionNameLabel.topAnchor.constraint(equalTo: nftCollectionCover.bottomAnchor, constant: 16),
            collectionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collectionNameLabel.heightAnchor.constraint(equalToConstant: 28),
            
            collectionAuthorLabel.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 13),
            collectionAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionAuthorLabel.heightAnchor.constraint(equalToConstant: 18),
            
            authorNameButton.centerYAnchor.constraint(equalTo: collectionAuthorLabel.centerYAnchor),
            authorNameButton.leadingAnchor.constraint(equalTo: collectionAuthorLabel.trailingAnchor, constant: 4),
            authorNameButton.heightAnchor.constraint(equalToConstant: 28),
            
            collectionDescriptionLabel.topAnchor.constraint(equalTo: authorNameButton.bottomAnchor),
            collectionDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func didTapAuthorButton() {
        delegate?.didTapAuthorButton(in: self)
    }
}
