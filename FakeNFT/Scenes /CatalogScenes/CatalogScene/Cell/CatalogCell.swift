//
//  CatalogCollectionCell.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit
import Kingfisher

final class CatalogCell: UICollectionViewCell, ReuseIdentifying {
    
    // MARK: - Constants
    
    static var defaultReuseIdentifier = "CatalogCell"
    
    // MARK: - UI
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold
        label.textColor = .blackCustom
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold
        label.textColor = .blackCustom
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    // MARK: - Public Methods
    
    func configure(with cellModel: CatalogCellModel) {
        titleLabel.text = cellModel.title
        countLabel.text = "(\(cellModel.size))"
        coverImageView.kf.setImage(with: cellModel.cover)
    }
}
    
    // MARK: - Private Methods
    
private extension CatalogCell {
    
    func setUp() {
        contentView.addSubviews([coverImageView, titleLabel, countLabel])
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 140),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            
            countLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 4),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4)
        ])
    }
}
