//
//  ProfileTableCell.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 16.10.2024.
//


import UIKit

final class ProfileTableCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "ProfileTableCell"
    
    let profileTableTitle: UILabel = {
        let table = UILabel()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        table.numberOfLines = 0
        table.textAlignment = .left
        return table
    }()
    
    private lazy var profileTableCustomImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        image.image = UIImage(systemName: "chevron.right", withConfiguration: boldConfig)
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.blackUniversal
        return image
    }()
    
    // MARK: - Private Methods
    
    func configureCell(title: String) {
        contentView.backgroundColor = .whiteUniversal
        [profileTableTitle,
         profileTableCustomImage].forEach { contentView.addSubview($0) }
        selectionStyle = .none
        profileTableTitle.text = title
        
        NSLayoutConstraint.activate([
            profileTableTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            profileTableTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileTableTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            profileTableCustomImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            profileTableCustomImage.widthAnchor.constraint(equalToConstant: 7.98),
            profileTableCustomImage.heightAnchor.constraint(equalToConstant: 13.86),
            profileTableCustomImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
        profileTableTitle.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
}
