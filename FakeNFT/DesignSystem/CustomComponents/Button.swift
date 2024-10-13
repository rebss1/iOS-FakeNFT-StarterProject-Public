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
    
    var color: UIColor = .ypBlack {
        didSet {
            backgroundColor = color
        }
    }
    
    var disabledColor: UIColor = .ypGrey
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = color
            } else {
                backgroundColor = disabledColor
                layer.borderColor = disabledColor.cgColor
            }
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
        backgroundColor = style == .flat ? .ypWhite : color
        setTitleColor(style == .flat ? color : .ypWhite, for: .normal)
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = isEnabled ? color.cgColor : UIColor.ypWhite.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc private func didTapButton() {
        action()
    }
}
