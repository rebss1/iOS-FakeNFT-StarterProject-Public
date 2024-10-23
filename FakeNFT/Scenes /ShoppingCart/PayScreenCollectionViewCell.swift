//
//  PayScreenCollectionViewCell.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 23.10.2024.
//

import UIKit

class PayScreenCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCell"
    private var isSelect = false
    private let namesOfImage = ["bitcoin","dogecoin","tether","apecoin","solana","etherium","cardano","shiba"]
    private let fullName = ["Bitcoin","Dogecoin","Tether","Apecoin","Solana","Ethereum","Cardano","Shiba Inu"]
    private let shortName = ["BTC","DOGE","USDT","APE","SOL","ETH","ADA","SHIB"]
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        return imageView
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .blackCustom
        return label
    }()
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
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
        setupImage()
        setupLabel()
        setupValueLabel()
        setSelected(isSelect)
    }
    
    private func setupImage(){
        contentView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
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
    
    func changeUI(number: Int) {
        imageView.image = UIImage(named: namesOfImage[number])
        label.text = fullName[number]
        valueLabel.text = shortName[number]
    }
}
