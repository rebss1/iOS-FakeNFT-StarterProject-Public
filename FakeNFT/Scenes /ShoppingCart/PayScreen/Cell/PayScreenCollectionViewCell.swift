//
//  PayScreenCollectionViewCell.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 23.10.2024.
//

import UIKit

final class PayScreenCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    static let defaultReuseIdentifier = "CustomCell"
    private var isSelect = false
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption2
        label.textColor = .blackCustom
        return label
    }()
    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blackUniversal
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption2
        label.textColor = .greenUniversal
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGreyCustom
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            setSelected(isSelect)
        }
    }
    
    private func setupUI(){
        layer.masksToBounds = true
        layer.cornerRadius = 12
        setupBackView()
        setupImage()
        setupLabel()
        setupValueLabel()
        setSelected(isSelect)
    }
    
    private func setupBackView(){
        contentView.addSubview(backView)
        backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        backView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    private func setupImage(){
        backView.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 36).isActive = true

    }
    
    private func setupLabel(){
        contentView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
    }
    
    private func setupValueLabel(){
        contentView.addSubview(valueLabel)
        valueLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }
    
    func setSelected(_ selected: Bool) {
        isSelect = selected
        if isSelect == true {
            layer.borderWidth = 1
            layer.borderColor = UIColor.blackCustom.cgColor
        } else {
            layer.borderWidth = 0
        }
    }
    
    func changeUI(with cellModel: PayScreenCellModel) {
        imageView.kf.setImage(with: cellModel.image)
        label.text = cellModel.title
        valueLabel.text = cellModel.name
    }
}
