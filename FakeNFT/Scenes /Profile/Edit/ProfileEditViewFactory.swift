//
//  ProfileEditViewFactory.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 16.10.2024.
//

import UIKit

final class ProfileEditViewFactory {
    
    static func createCloseButton() -> UIButton {
        let btn = UIButton(type: .system)
        
        btn.setImage(.close, for: .normal)
        btn.tintColor = .blackUniversal
        return btn
    }
    
    static func createScrollView() -> UIScrollView {
        let view = UIScrollView()
        return view
    }
    
    static func createAvatarImageView() -> UIImageView {
        let view = UIImageView()
        view.image = .profileAvatarMock
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 35
        return view
    }
    
    static func createAvatarButton() -> UIButton {
        let btn = UIButton()
        btn.setTitle(NSLocalizedString("Profile.changePhoto", comment: ""), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 10, weight: .medium)
        btn.titleLabel?.textColor = .whiteUniversal
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.lineBreakMode = .byWordWrapping
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = UIColor(hexString: "#1A1B22").withAlphaComponent(0.6)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 35
        return btn
    }
    
    static func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .blackUniversal
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = text
        return label
    }
    
    static func createTextField() -> UITextField {
        let textField = UITextField()
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.backgroundColor = .lightGreyCustom
        textField.textColor = .blackUniversal
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.rightView = rightView
        textField.rightViewMode = .always
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        return textField
    }
    
    static func createTextView() -> UITextView {
        let view = UITextView()
        view.backgroundColor = .lightGreyCustom
        view.textColor = .blackUniversal
        view.textContainerInset = .init(top: 11, left: 16, bottom: 11, right: 16)
        view.font = .systemFont(ofSize: 17, weight: .regular)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }
    
}

