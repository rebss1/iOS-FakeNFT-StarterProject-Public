//
//  FavouriteNftCollectionCell.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import UIKit
import Kingfisher

protocol ProfileFavouriteNFTCollectionCellDelegate: AnyObject {
    
    func changeLike(id: String, isLiked: Bool)
}

final class ProfileFavouriteNFTCollectionCell: UICollectionViewCell, ReuseIdentifying {
    
    private static let totalStars = 5
    
    weak var delegate: ProfileFavouriteNFTCollectionCellDelegate?
    
    private lazy var likeButton: UIButton = {
        let button: UIButton = UIButton()
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageViewNFT: UIImageView = {
        let image: UIImageView = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var labelName: UILabel = {
        let label: UILabel = UILabel()
        label.font = .bodyBold
        label.textColor = .blackUniversal
        return label
    }()
    
    private lazy var labelPriceValue: UILabel = {
        let label: UILabel = UILabel()
        label.font = .caption1
        return label
    }()
    
    private lazy var stackNFT: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var stackRating: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.spacing = 2
        return stack
    }()
    
    private lazy var viewNFTContent: UIView = UIView()
    
    private var model: FavouriteNFT?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(_ model: FavouriteNFT) {
        self.model = model
        
        labelName.text = model.name
        labelPriceValue.text = "\(model.price) ETH"
        
        if let urlString = model.imageUrl, let url = URL(string: urlString) {
            imageViewNFT.kf.setImage(with: url)
        }
        
        model.isLiked ? likeButton.setImage(.likeActive, for: .normal) : likeButton.setImage(.likeNoActive, for: .normal)
        
        stackRating.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        let activeStarImage = UIImage(systemName: "star.fill")?
            .withTintColor(.yellowUniversal, renderingMode: .alwaysOriginal)
        let inactiveStarImage = UIImage(systemName: "star.fill")?
            .withTintColor(.lightGreyCustom, renderingMode: .alwaysOriginal)
        
        for index in 1...ProfileFavouriteNFTCollectionCell.totalStars {
            let starImageView = UIImageView()
            starImageView.contentMode = .scaleAspectFit
            starImageView.image = index <= model.rating ? activeStarImage : inactiveStarImage
            stackRating.addArrangedSubview(starImageView)
            
            starImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        }
    }
    
    override func prepareForReuse() {
        for view in stackRating.arrangedSubviews {
            stackRating.removeArrangedSubview(view)
        }
    }
    
    private func addElements(){
        contentView.addSubview(viewNFTContent)
        
        viewNFTContent.addSubview(imageViewNFT)
        viewNFTContent.addSubview(likeButton)
        viewNFTContent.addSubview(stackNFT)
        
        stackNFT.addArrangedSubview(labelName)
        stackNFT.addArrangedSubview(stackRating)
        stackNFT.addArrangedSubview(labelPriceValue)
        
    }
    
    private func setupConstraints(){
        [imageViewNFT, likeButton,
         stackNFT, labelName, stackRating,
         labelPriceValue, viewNFTContent].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            viewNFTContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewNFTContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewNFTContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewNFTContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageViewNFT.heightAnchor.constraint(equalToConstant: 80),
            imageViewNFT.widthAnchor.constraint(equalToConstant: 80),
            imageViewNFT.topAnchor.constraint(equalTo: viewNFTContent.topAnchor),
            imageViewNFT.leadingAnchor.constraint(equalTo: viewNFTContent.leadingAnchor),
            
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.topAnchor.constraint(equalTo: viewNFTContent.topAnchor, constant: 0),
            likeButton.leadingAnchor.constraint(equalTo: viewNFTContent.leadingAnchor, constant: 50),
            
            stackNFT.heightAnchor.constraint(equalToConstant: 66),
            
            stackNFT.leadingAnchor.constraint(equalTo: imageViewNFT.trailingAnchor, constant: 8),
            stackNFT.trailingAnchor.constraint(equalTo: viewNFTContent.trailingAnchor),
            stackNFT.centerYAnchor.constraint(equalTo: viewNFTContent.centerYAnchor),
            
            stackRating.heightAnchor.constraint(equalToConstant: 12),
            stackRating.widthAnchor.constraint(equalToConstant: 68),
        ])
    }
    
    @objc
    private func likeButtonTapped() {
        guard let model else { return }
        
        delegate?.changeLike(id: model.id, isLiked: !model.isLiked)
    }
    
}
