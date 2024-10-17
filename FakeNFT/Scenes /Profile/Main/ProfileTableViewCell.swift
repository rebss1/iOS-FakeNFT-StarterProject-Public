//
//  ProfileTableViewCell.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 16.10.2024.
//


import UIKit

final class ProfileTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ProfileTableViewCell"
    
    private enum Margin {
        static let left: CGFloat = 16
        static let right: CGFloat = 16
        static let countLeft: CGFloat = 8
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blackUniversal
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blackUniversal
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = .profileChevronForward
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .whiteUniversal
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(chevronImageView)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.left),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Margin.countLeft),
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.right),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func update(title: String, count: Int?) {
        titleLabel.text = title
        countLabel.text = switch count {
        case .some(let count): "(\(count))"
        default: ""
        }
    }
    
}

