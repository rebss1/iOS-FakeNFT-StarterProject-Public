//
//  ProfileNftRatingView.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import UIKit

final class ProfileNftRatingView: UIStackView {
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func updateRating(_ value: Int) {
        let value = value < 0 ? 0 : (value > 5 ? 5 : value)
        (0..<value).forEach {
            let view = arrangedSubviews[$0] as? UIImageView
            view?.image = .starActive
        }
        (value..<5).forEach {
            let view = arrangedSubviews[$0] as? UIImageView
            view?.image = .starNoActive
        }
    }
    
    private func commonInit() {
        axis = .horizontal
        alignment = .fill
        distribution = .fill
        spacing = 2
        
        (0..<5).forEach {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.accessibilityIdentifier = "star_\($0)"
            view.image = .starNoActive
            addArrangedSubview(view)
        }
    }
    
}
