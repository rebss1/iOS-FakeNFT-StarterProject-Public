//
//  Button.swift
//  Tracker
//
//  Created by Илья Лощилов on 05.07.2024.
//

import Foundation
import UIKit

enum ButtonStyle {
    case normal
    case flat
}

final class Button: UIButton {
    
    var action: () -> Void
    
    var style: ButtonStyle = .normal
    
    var color: UIColor = .blackCustom {
        didSet {
            backgroundColor = color
        }
    }
    
    init(title: String,
         style: ButtonStyle,
         color: UIColor,
         action: @escaping () -> Void = {}
    ) {
        self.action = action
        self.style = style
        self.color = color
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = style == .flat ? .whiteCustom : color
        setTitleColor(style == .flat ? color : .whiteCustom, for: .normal)
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = isEnabled ? color.cgColor : UIColor.whiteCustom.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func didTapButton() {
        action()
    }
}
