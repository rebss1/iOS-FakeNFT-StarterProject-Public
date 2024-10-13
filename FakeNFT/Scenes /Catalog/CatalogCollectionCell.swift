//
//  CatalogCollectionCell.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit

final class CatalogCollectionCell: UICollectionViewCell {
    
    // MARK: - Constants

    static let identifier = "CatalogCollectionCell"
    
    // MARK: - Public Properties

    private lazy var collectionWidth = collectionView.frame.width
    
    // MARK: - UIViews

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.layer.cornerRadius = 12
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NFTPreviewCell.self, forCellWithReuseIdentifier: NFTPreviewCell.identifier)
        return collectionView
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
    
    // MARK: - Public Methods
    
    func setUpCell() {
        
        setUp()
    }
    
    // MARK: - Private Methods
    
    private func setUp() {
        contentView.addSubviews([collectionView, titleLabel, countLabel])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            
            countLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 4),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4)
        ])
    }
}

extension CatalogCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 3 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
}

extension CatalogCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellWidth = collectionWidth - 32
        return CGSize(width: cellWidth, height: 140)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat { 0 }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat { 0 }
}
