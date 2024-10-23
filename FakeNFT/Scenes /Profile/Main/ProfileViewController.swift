//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private enum Margin {
        static let left: CGFloat = 16
        static let right: CGFloat = 16
        static let editTop: CGFloat = 2
        static let editRight: CGFloat = 9
        static let avatarTop: CGFloat = 20
        static let avatarDia: CGFloat = 70
        static let headerLeft: CGFloat = 16
        static let descriptionTop: CGFloat = 20
        static let linkTop: CGFloat = 8
        static let tableTop: CGFloat = 40
    }
    
    private enum Constants {
        static let tableCellHeight: CGFloat = 54
    }
    
    private enum TableItem: CaseIterable {
        case myNft
        case favoritesNft
        case aboutDeveloper
    }
    
    private let editButton: UIButton
    private let avatarImageView: UIImageView
    private let headerLabel: UILabel
    private let descriptionLabel: UILabel
    private let linkLabel: UILabel
    private let tableView: UITableView
    
    private let tableItems = TableItem.allCases
    private let viewFactory = ProfileViewFactory.self
    private let servicesAssembly: ServicesAssembly
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(servicesAssembly: ServicesAssembly) {
        self.editButton = viewFactory.createEditButton()
        self.avatarImageView = viewFactory.createAvatarImageView()
        self.headerLabel = viewFactory.createHeaderLabel()
        self.descriptionLabel = viewFactory.createDescriptionLabel()
        self.linkLabel = viewFactory.createLinkLabel()
        self.tableView = viewFactory.createTableView()
        
        self.servicesAssembly = servicesAssembly
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
}

// MARK: - Helpers
private extension ProfileViewController {
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        navigationItem.rightBarButtonItem = .init(customView: editButton)
        view.backgroundColor = .whiteUniversal
        
        [
            editButton,
            avatarImageView,
            headerLabel,
            descriptionLabel,
            linkLabel,
            tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.avatarTop),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left),
            avatarImageView.widthAnchor.constraint(equalToConstant: Margin.avatarDia),
            avatarImageView.heightAnchor.constraint(equalToConstant: Margin.avatarDia),
            headerLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 0),
            headerLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Margin.headerLeft),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.right),
            descriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Margin.descriptionTop),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right),
            linkLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Margin.descriptionTop),
            linkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left),
            linkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right),
            tableView.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: Margin.tableTop),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
}

// MARK: - Actions
extension ProfileViewController {

    @objc private func editAction() {
        let vc = ProfileEditViewController(servicesAssembly: servicesAssembly) { [weak self]() in
            guard let self else {
                return
            }
            dismiss(animated: true)
        }
        present(vc, animated: true, completion: nil)
    }

}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? ProfileTableViewCell
        guard let cell else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.update(title: NSLocalizedString("Profile.myNft", comment: ""), count: 0)
        case 1:
            cell.update(title: NSLocalizedString("Profile.favoritesNft", comment: ""), count: 0)
        case 2:
            cell.update(title: NSLocalizedString("Profile.aboutDeveloper", comment: ""), count: nil)
        default:
            break
        }
        return cell
    }
    
}
