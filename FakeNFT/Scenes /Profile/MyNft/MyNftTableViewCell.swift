//
//  MyNftTableViewCell.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import UIKit

protocol ProfileMyNFTTableCellDelegate: AnyObject {
    
    func changeLike(id: String, isLiked: Bool)
}

final class ProfileMyNFTTableCell: UITableViewCell, ReuseIdentifying {
    
    private static let totalStars = 5
    
    weak var delegate: ProfileMyNFTTableCellDelegate?
    
    private var model: MyNFT?
    
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
    
    private lazy var labelAuthor: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption2
        label.textColor = .blackUniversal
        return label
    }()
    
    private lazy var labelFrom: UILabel = {
        let label: UILabel = UILabel()
        label.text = "от"
        label.font = .caption1
        return label
    }()
    
    private lazy var labelPrice: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Цена"
        label.font = .caption2
        return label
    }()
    
    private lazy var labelPriceValue: UILabel = {
        let label: UILabel = UILabel()
        label.font = .bodyBold
        return label
    }()
    
    private lazy var stackNFT: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var stackNFTLeft: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var stackNFTRight: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var stackRating: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    private lazy var viewAuthor: UIView = {
        let view: UIView = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var viewNFTContent: UIView = UIView()
    
    
    @objc
    private func likeButtonTapped() {
        guard let model else { return }
        
        delegate?.changeLike(id: model.id, isLiked: !model.isLiked)
    }
    
    func configCell(_ model: MyNFT) {
        backgroundColor = .whiteUniversal
        selectionStyle = .none
        addElements()
        setupConstraints()
        
        self.model = model
        
        labelName.text = model.name
        labelAuthor.text = model.author
        labelPriceValue.text = "\(model.price) ETH"
        
        if let urlString = model.imageUrl, let url = URL(string: urlString) {
            imageViewNFT.kf.setImage(with: url)
        }
        
        model.isLiked ? likeButton.setImage(.likeActive, for: .normal) :
        likeButton.setImage(.likeNoActive, for: .normal)
        

        stackRating.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        let activeStarImage = UIImage(systemName: "star.fill")?
            .withTintColor(.yellowUniversal, renderingMode: .alwaysOriginal)
        let inactiveStarImage = UIImage(systemName: "star.fill")?
            .withTintColor(.lightGreyCustom, renderingMode: .alwaysOriginal)
        
        for index in 1...ProfileMyNFTTableCell.totalStars {
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
        
        stackNFT.addArrangedSubview(stackNFTLeft)
        stackNFT.addArrangedSubview(stackNFTRight)
        
        stackNFTLeft.addArrangedSubview(labelName)
        stackNFTLeft.addArrangedSubview(stackRating)
        stackNFTLeft.addArrangedSubview(viewAuthor)
        
        viewAuthor.addSubview(labelFrom)
        viewAuthor.addSubview(labelAuthor)
        
        stackNFTRight.addArrangedSubview(labelPrice)
        stackNFTRight.addArrangedSubview(labelPriceValue)
    }
    
    private func setupConstraints(){
        [likeButton, imageViewNFT, stackNFT,
         stackNFTLeft, labelName, stackRating, viewAuthor, labelFrom, labelAuthor,
         stackNFTRight, labelPrice, labelPriceValue, viewNFTContent].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            viewNFTContent.heightAnchor.constraint(equalToConstant: 108),
            viewNFTContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            viewNFTContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            viewNFTContent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            imageViewNFT.heightAnchor.constraint(equalToConstant: 108),
            imageViewNFT.widthAnchor.constraint(equalToConstant: 108),
            imageViewNFT.leadingAnchor.constraint(equalTo: viewNFTContent.leadingAnchor),
            imageViewNFT.centerYAnchor.constraint(equalTo: viewNFTContent.centerYAnchor),
            
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.topAnchor.constraint(equalTo: viewNFTContent.topAnchor, constant: 0),
            likeButton.leadingAnchor.constraint(equalTo: viewNFTContent.leadingAnchor, constant: 68),
            
            stackNFTLeft.heightAnchor.constraint(equalToConstant: 62),
            stackNFTLeft.widthAnchor.constraint(equalToConstant: 95),
            stackNFTRight.heightAnchor.constraint(equalToConstant: 42),
            stackNFTRight.widthAnchor.constraint(equalToConstant: 90),
            
            stackNFT.topAnchor.constraint(equalTo: viewNFTContent.topAnchor, constant: 23),
            stackNFT.leadingAnchor.constraint(equalTo: viewNFTContent.leadingAnchor, constant: 128),
            stackNFT.trailingAnchor.constraint(equalTo: viewNFTContent.trailingAnchor, constant: 0),
            stackNFT.bottomAnchor.constraint(equalTo: viewNFTContent.bottomAnchor, constant: -23),
            
            stackRating.heightAnchor.constraint(equalToConstant: 12),
            stackRating.widthAnchor.constraint(equalToConstant: 68),
            
            viewAuthor.heightAnchor.constraint(equalToConstant: 20),
            viewAuthor.widthAnchor.constraint(equalToConstant: 78),
            
            labelFrom.leadingAnchor.constraint(equalTo: viewAuthor.leadingAnchor),
            labelFrom.centerYAnchor.constraint(equalTo: viewAuthor.centerYAnchor),
            
            labelAuthor.leadingAnchor.constraint(equalTo: labelFrom.trailingAnchor, constant: 5),
            labelAuthor.centerYAnchor.constraint(equalTo: viewAuthor.centerYAnchor),
        ])
    }
}
