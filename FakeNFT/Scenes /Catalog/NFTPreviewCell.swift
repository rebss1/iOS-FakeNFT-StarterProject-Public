//
//  NFTPreviewCell.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit

final class NFTPreviewCell: UICollectionViewCell {
    
    // MARK: - Constants

    static let identifier = "NFTPreviewCell"
    
    // MARK: - UIViews

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Public Methods
    
    func setUpCell(with image: UIImage) {
        imageView.image = image
        setUp()
    }
    
    // MARK: - Private Methods
    
    private func setUp() {
        contentView.addSubviews([imageView])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

