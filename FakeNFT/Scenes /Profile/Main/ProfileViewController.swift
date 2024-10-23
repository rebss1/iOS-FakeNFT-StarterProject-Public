//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    
    func openWebView(url: String)
}

final class ProfileViewController: UIViewController & ProfileViewControllerProtocol {
    
    //MARK: - Properties
    var presenter: ProfilePresenterProtocol?
    let servicesAssembly: ServicesAssembly
    
    
    //MARK: - Private properties
    
    private lazy var profileEditButton: UIBarButtonItem = {
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "square.and.pencil", withConfiguration: boldConfig)
        button.action = #selector(profileEditTapped)
        button.target = self
        return button
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.heightAnchor.constraint(equalToConstant: 70).isActive = true
        stack.spacing = 16
        return stack
    } ()
    
    private lazy var profileAvatar: UIImageView = {
        let avatar = UIImageView()
        avatar.image = .profileAvatarMock
        avatar.contentMode = .scaleAspectFill
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatar.layer.cornerRadius = 35
        avatar.layer.masksToBounds = true
        return avatar
    }()
    
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blackUniversal
        label.font = .headline2
        label.textAlignment = NSTextAlignment.left
        label.heightAnchor.constraint(equalToConstant: 28).isActive = true
        return label
    }()
    
    private lazy var profileBioTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .caption2
        textView.textContainer.maximumNumberOfLines = 4
        textView.isEditable = false
        textView.textColor = .blackUniversal
        textView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        textView.backgroundColor = .whiteUniversal
        return textView
    }()
    
    private lazy var profileLinkTextView: UITextView =  {
        let link = UITextView()
        link.translatesAutoresizingMaskIntoConstraints = false
        link.dataDetectorTypes = .link
        link.textColor = .blueUniversal
        link.font = .caption1
        link.textAlignment = NSTextAlignment.left
        link.heightAnchor.constraint(equalToConstant: 28).isActive = true
        link.isScrollEnabled = false
        link.isEditable = false
        link.backgroundColor = .whiteUniversal
        return link
    }()
    
    private lazy var profileTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.heightAnchor.constraint(equalToConstant: 150).isActive = true
        table.separatorStyle = .none
        table.register(
            ProfileTableCell.self,
            forCellReuseIdentifier: ProfileTableCell.reuseIdentifier
        )
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .whiteUniversal
        return table
    }()
    
    
    
    //MARK: - Init
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        view.backgroundColor = .whiteUniversal
        
        profileAddElements()
        profileSetupLayout()
        profileSetText()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
    func openWebView(url: String) {
        if let url = URL(string: url) {
            let webVC = ProfileWebViewController(url: url)
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    //MARK: - Private Methods
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = profileEditButton
        navigationItem.rightBarButtonItem?.tintColor = .blackUniversal
    }
    
    
    @objc
    private func profileEditTapped(){
        print("profile edit button tapped")
        let editingVC = ProfileEditingViewController()
        let presenter = ProfileEditingPresenter()
        
        editingVC.presenter = presenter
        presenter.view = editingVC
        
        let navVC = UINavigationController(rootViewController: editingVC)
        present(navVC, animated: true)
    }
    
    private func profileAddElements() {
        [profileStackView,
         profileBioTextView,
         profileLinkTextView,
         profileTableView].forEach { view.addSubview($0) }
        
        [profileAvatar,
         profileNameLabel].forEach { profileStackView.addSubview($0) }
    }
    
    private func profileSetupLayout() {
        NSLayoutConstraint.activate([
            profileStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            profileAvatar.topAnchor.constraint(equalTo: profileStackView.topAnchor),
            profileAvatar.leadingAnchor.constraint(equalTo: profileStackView.leadingAnchor),
            
            profileNameLabel.centerYAnchor.constraint(equalTo: profileAvatar.centerYAnchor),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileAvatar.trailingAnchor, constant: 16),
            
            profileBioTextView.topAnchor.constraint(equalTo: profileStackView.bottomAnchor, constant: 20),
            profileBioTextView.leadingAnchor.constraint(equalTo: profileStackView.leadingAnchor),
            profileBioTextView.trailingAnchor.constraint(equalTo: profileStackView.trailingAnchor),
            
            profileLinkTextView.topAnchor.constraint(equalTo: profileBioTextView.bottomAnchor, constant: 8),
            profileLinkTextView.leadingAnchor.constraint(equalTo: profileStackView.leadingAnchor),
            
            profileTableView.topAnchor.constraint(equalTo: profileLinkTextView.bottomAnchor, constant: 40),
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func profileSetText() {
        let profileName = ProfileConstants.profileNameString
        profileNameLabel.text = profileName
        
        let profileBio = ProfileConstants.profileBioString
        profileBioTextView.text = profileBio
        
        let profileWebLink = ProfileConstants.profileWebLinkString
        profileLinkTextView.text = profileWebLink
    }
    
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableCell.reuseIdentifier, for: indexPath) as? ProfileTableCell else { return UITableViewCell() }
        var title = ""
        switch indexPath.row {
        case 0: title = "Мои NFT (112)"
        case 1: title = "Избранные NFT (11)"
        case 2: title = "О разработчике"
        default:
            break
        }
        cell.configureCell(title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        switch index {
//        case 0:
//            showMyNFT()
//        case 1:
//            showFavouritesNFT()
        case 2:
            presenter?.openAboutDeveloper()
        default:
            break
        }
    }
//    
//    private func showMyNFT() {
//        let myNFTVC = MyNFTViewController()
//        let presenter = MyNFTPresenter()
//        
//        myNFTVC.presenter = presenter
//        presenter.view = myNFTVC
//        
//        navigationController?.pushViewController(myNFTVC, animated: true)
//    }
//    
//    private func showFavouritesNFT() {
//        let favouriteVC = FavouriteNFTViewController()
//        let presenter = FavouriteNFTPresenter()
//        
//        favouriteVC.presenter = presenter
//        presenter.view = favouriteVC
//        
//        navigationController?.pushViewController(favouriteVC, animated: true)
//    }
    
}
