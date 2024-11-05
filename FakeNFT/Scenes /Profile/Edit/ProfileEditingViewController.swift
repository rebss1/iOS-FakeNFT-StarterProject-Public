//
//  ProfileEditingViewController.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import UIKit

protocol ProfileEditingViewControllerProtocol: AnyObject {
    func updateTitles(profileName: String, profileBio: String, profileWebLink: URL?, avatar: URL?)
    func refreshAvatar(url: URL?)
}

final class ProfileEditingViewController: UIViewController {

    var presenter: ProfileEditingPresenterProtocol?

    private lazy var profileCloseButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold
        )
        button.image = UIImage(systemName: "xmark", withConfiguration: config)
        button.action = #selector(closeButtonTapped)
        button.target = self
        return button
    }()

    private lazy var profileAvatar: UIImageView = {
        let avatar = UIImageView()
        avatar.image = .profileNoActive
        avatar.contentMode = .scaleAspectFill
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatar.layer.cornerRadius = 35
        avatar.layer.masksToBounds = true
        return avatar

    }()

    private lazy var profileAvatarBackground: UIView = {
        let view = UIView(frame: profileAvatar.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blackUniversal.withAlphaComponent(0.6)
        return view
    }()

    private lazy var labelChangePhoto: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = .whiteUniversal
        label.text = "Сменить фото"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changePhotoTapped))
        label.addGestureRecognizer(tapGesture)
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = .blackUniversal
        label.text = "Имя"
        return label
    }()

    private lazy var  profileNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.font = .bodyRegular
        textField.backgroundColor = .lightGreyCustom
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:16, height:10))
        textField.leftViewMode = .always
        textField.leftView = spacerView
        textField.clearButtonMode = .whileEditing
        textField.textColor = .blackUniversal
        return textField
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = .blackUniversal
        label.text = "Описание"
        return label
    }()

    private lazy var profileBioTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 12
        textView.font = .bodyRegular
        textView.backgroundColor = .lightGreyCustom
        textView.textContainerInset = UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 16)
        textView.textColor = .blackUniversal
        return textView
    }()

    private lazy var siteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = .blackUniversal
        label.text = "Сайт"
        return label
    }()

    private lazy var profileLinkTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.font = .bodyRegular
        textField.backgroundColor = .lightGreyCustom
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:16, height:10))
        textField.leftViewMode = .always
        textField.leftView = spacerView
        textField.clearButtonMode = .whileEditing
        textField.textColor = .blackUniversal
        return textField
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .whiteUniversal
        tabBarController?.tabBar.isHidden = true
        setupNavBar()
        addElements()
        setupConstraints()

        presenter?.updateProfile()
    }

    override func viewWillDisappear(_ animated: Bool) {
        presenter?.saveProfile(
            name: profileNameTextField.text ?? "",
            description: profileBioTextView.text ?? "",
            website: profileLinkTextField.text ?? ""
        )

        super.viewWillDisappear(animated)
    }

    // MARK: - Private Methods
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = profileCloseButton
        navigationItem.rightBarButtonItem?.tintColor = .blackUniversal
    }

    private func addElements() {
        [profileAvatar, nameLabel, profileNameTextField,
         profileBioTextView, descriptionLabel, siteLabel, profileLinkTextField, labelChangePhoto].forEach { view.addSubview($0) }

        profileAvatar.addSubview(profileAvatarBackground)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileAvatar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileAvatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            profileAvatar.heightAnchor.constraint(equalToConstant: 70),
            profileAvatar.widthAnchor.constraint(equalToConstant: 70),

            profileAvatarBackground.centerXAnchor.constraint(equalTo: profileAvatar.centerXAnchor),
            profileAvatarBackground.centerYAnchor.constraint(equalTo: profileAvatar.centerYAnchor),
            profileAvatarBackground.heightAnchor.constraint(equalToConstant: 70),
            profileAvatarBackground.widthAnchor.constraint(equalToConstant: 70),

            labelChangePhoto.centerXAnchor.constraint(equalTo: profileAvatar.centerXAnchor),
            labelChangePhoto.centerYAnchor.constraint(equalTo: profileAvatar.centerYAnchor),
            labelChangePhoto.heightAnchor.constraint(equalToConstant: 70),
            labelChangePhoto.widthAnchor.constraint(equalToConstant: 70),

            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: profileAvatar.bottomAnchor, constant: 24),
            nameLabel.heightAnchor.constraint(equalToConstant: 28),

            profileNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            profileNameTextField.heightAnchor.constraint(equalToConstant: 44),

            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: profileNameTextField.bottomAnchor, constant: 24),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 28),

            profileBioTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileBioTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileBioTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            profileBioTextView.heightAnchor.constraint(equalToConstant: 132),

            siteLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            siteLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            siteLabel.topAnchor.constraint(equalTo: profileBioTextView.bottomAnchor, constant: 24),
            siteLabel.heightAnchor.constraint(equalToConstant: 28),

            profileLinkTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileLinkTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileLinkTextField.topAnchor.constraint(equalTo: siteLabel.bottomAnchor, constant: 8),
            profileLinkTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc private func closeButtonTapped() {
        print("tapped")
        dismiss(animated: true)
    }

    @objc private func changePhotoTapped() {
        print("changePhotoTapped")
        
        let alertController = UIAlertController(title: "Загрузить изображение", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Введите URL изображения"
        }
        let confirmAction = UIAlertAction(title: "Изменить", style: .default) { [weak self, weak alertController] _ in
            guard let urlString = alertController?.textFields?.first?.text else {
                return
            }
            if let url = URL(string: urlString) {
                self?.presenter?.updateAvatar(url)
            }
        }

        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

// MARK: - ProfileEditingViewControllerProtocol
extension ProfileEditingViewController: ProfileEditingViewControllerProtocol {
    func refreshAvatar(url: URL?) {
        guard let url else { return }

        profileAvatar.kf.setImage(
            with: url,
            placeholder: UIImage.profileNoActive
        )
    }
    

    func updateTitles(profileName: String, profileBio: String, profileWebLink: URL?, avatar: URL?) {
        profileNameTextField.text = profileName
        profileBioTextView.text = profileBio
        profileLinkTextField.text = profileWebLink?.absoluteString ?? ""

        guard let avatar else { return }

        profileAvatar.kf.setImage(
            with: avatar,
            placeholder: UIImage.profileNoActive
        )
    }
}
