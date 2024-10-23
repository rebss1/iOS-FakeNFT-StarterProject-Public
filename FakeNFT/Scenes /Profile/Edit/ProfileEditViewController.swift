//
//  ProfileEditViewController.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 16.10.2024.
//

import UIKit

final class ProfileEditViewController: UIViewController {
    
    private enum Margin {
        static let top: CGFloat = 16
        static let left: CGFloat = 16
        static let right: CGFloat = 16
        static let avatarTop: CGFloat = 22
        static let avatarDia: CGFloat = 70
        static let labelTop: CGFloat = 24
        static let textFieldTop: CGFloat = 8
    }
    
    private enum Constants {
        static let textFieldHeight: CGFloat = 44
        static let textViewHeight: CGFloat = 132
    }
    
    private let closeButton: UIButton
    private let avatarImageView: UIImageView
    private let avatarButton: UIButton
    private let nameLabel: UILabel
    private let nameTextField: UITextField
    private let descriptionLabel: UILabel
    private let descriptionTextView: UITextView
    private let linkLabel: UILabel
    private let linkTextField: UITextField
    
    private let viewFactory = ProfileEditViewFactory.self
    private let servicesAssembly: ServicesAssembly
    
    private var onCloseCallback: (()->(Void))?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(servicesAssembly: ServicesAssembly, onClose: (() -> Void)? = nil) {
        self.closeButton = viewFactory.createCloseButton()
        self.avatarImageView = viewFactory.createAvatarImageView()
        self.avatarButton = viewFactory.createAvatarButton()
        self.nameLabel = viewFactory.createLabel(NSLocalizedString(" profile.nameLabelText", comment: ""))
        self.nameTextField = viewFactory.createTextField()
        self.descriptionLabel = viewFactory.createLabel(NSLocalizedString(" profile.descriptionLabelText", comment: ""))
        self.descriptionTextView = viewFactory.createTextView()
        self.linkLabel = viewFactory.createLabel(NSLocalizedString("profile.linkLabelText", comment:""))
        self.linkTextField = viewFactory.createTextField()
        
        self.servicesAssembly = servicesAssembly
        self.onCloseCallback = onClose
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
}

// MARK: - Helpers
private extension ProfileEditViewController {
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .whiteUniversal
        
        [
            closeButton,
            avatarImageView,
            avatarButton,
            nameLabel,
            nameTextField,
            descriptionLabel,
            descriptionTextView,
            linkLabel,
            linkTextField
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.top),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right),
            avatarImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Margin.avatarTop),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            avatarImageView.widthAnchor.constraint(equalToConstant: Margin.avatarDia),
            avatarImageView.heightAnchor.constraint(equalToConstant: Margin.avatarDia),
            avatarButton.widthAnchor.constraint(equalToConstant: Margin.avatarDia),
            avatarButton.heightAnchor.constraint(equalToConstant: Margin.avatarDia),
            avatarButton.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor, constant: 0),
            avatarButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Margin.labelTop),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.textFieldTop),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0),
            nameTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0),
            nameTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            descriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Margin.labelTop),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 0),
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Margin.textFieldTop),
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: 0),
            descriptionTextView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 0),
            descriptionTextView.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),
            linkLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: Margin.labelTop),
            linkLabel.leadingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: 0),
            linkLabel.trailingAnchor.constraint(equalTo: descriptionTextView.trailingAnchor, constant: 0),
            linkTextField.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: Margin.textFieldTop),
            linkTextField.leadingAnchor.constraint(equalTo: linkLabel.leadingAnchor, constant: 0),
            linkTextField.trailingAnchor.constraint(equalTo: linkLabel.trailingAnchor, constant: 0),
            linkTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
        ])
    }
    
}

// MARK: - Actions
private extension ProfileEditViewController {
    
    @objc private func closeAction() {
        onCloseCallback?()
    }
    
}
