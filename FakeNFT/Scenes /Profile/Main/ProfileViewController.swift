//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit
import ProgressHUD

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }

    func setLoader(_ visible: Bool)
    func openWebView(url: URL?)
    func updateProfileDetails(profile: ProfileUIModel)
    func updateProfileAvatar(avatar: URL?)
    func showError(_ model: ErrorModel)
    func openMyNfts(profile: ProfileResponse)
    func openFavouriteNfts(profile: ProfileResponse)
    func openEditProfile(
        avatarUrl: URL?,
        name: String,
        description: String,
        link: URL?,
        likes: [String]
    )
}

final class ProfileViewController: UIViewController {

    // MARK: - Properties
    var presenter: ProfilePresenterProtocol?
    let servicesAssembly: ServicesAssembly

    // MARK: - Private properties
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
    }()

    var profileAvatar: UIImageView = {
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

    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blackUniversal
        label.font = .headline3
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
            forCellReuseIdentifier: ProfileTableCell.defaultReuseIdentifier
        )
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .whiteUniversal
        table.isScrollEnabled = false
        return table
    }()

    private var likedNftsCount: String = ""
    private var myNftsCount: String = ""

    // MARK: - Init
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        
        view.backgroundColor = .whiteUniversal
        
        profileAddElements()
        profileSetupLayout()

        presenter?.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false

        profileAvatar.kf.indicatorType = .activity
        
        presenter?.viewDidLoad()
    }

    func openWebView(url: URL?) {
        guard let url else { return}
            let webVC = ProfileWebViewController(url: url)
            navigationController?.pushViewController(webVC, animated: true)
    }

    // MARK: - Private Methods
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = profileEditButton
        navigationItem.rightBarButtonItem?.tintColor = .blackUniversal
    }

    @objc
    private func profileEditTapped() {
        presenter?.onEditProfileClicked()
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
            profileLinkTextView.trailingAnchor.constraint(equalTo: profileStackView.trailingAnchor),

            profileTableView.topAnchor.constraint(equalTo: profileLinkTextView.bottomAnchor, constant: 40),
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableCell.defaultReuseIdentifier, for: indexPath) as? ProfileTableCell else { return UITableViewCell() }
        var title = ""
        switch indexPath.row {
        case 0:
            title = "Мои NFT (\(myNftsCount))"
        case 1:
            title = "Избранные NFT (\(likedNftsCount))"
        case 2:
            title = "О разработчике"
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
        case 0:
            presenter?.onMyNftsClicked()
        case 1:
            presenter?.onFavouriteNftsClicked()
        case 2:
            presenter?.openAboutDeveloper()
        default:
            break
        }
    }
}

// MARK: - ProfileViewControllerProtocol
extension ProfileViewController: ProfileViewControllerProtocol {

    func openEditProfile(
        avatarUrl: URL?,
        name: String,
        description: String,
        link: URL?,
        likes: [String]
    ) {
        let editingVC = ProfileEditingViewController()

        editingVC.presenter = ProfileEditingPresenter(
            view: editingVC,
            servicesAssembly: servicesAssembly,
            delegate: self,
            initAvatarUrl: avatarUrl,
            initName: name,
            initDescription: description,
            website: link,
            likes: likes
        )

        let navVC = UINavigationController(rootViewController: editingVC)
        present(navVC, animated: true)
    }

    func setLoader(_ visible: Bool) {
        profileStackView.isHidden = visible
        profileBioTextView.isHidden = visible
        profileLinkTextView.isHidden = visible
        profileTableView.isHidden = visible

        visible ? ProgressHUD.show() : ProgressHUD.dismiss()
    }

    func openFavouriteNfts(profile: ProfileResponse) {
        let favouriteVC = FavouriteNFTViewController()

        favouriteVC.presenter = FavouriteNFTPresenter(
            profile: profile,
            view: favouriteVC,
            profileNftService: ProfileNftServiceImpl(
                networkClient: DefaultNetworkClient()
            ),
            profileService: servicesAssembly.profileService
        )

        navigationController?.pushViewController(favouriteVC, animated: true)
    }

    func openMyNfts(profile: ProfileResponse) {
        let myNFTVC = MyNFTViewController()

        myNFTVC.presenter = MyNFTPresenter(
            profile: profile,
            view: myNFTVC,
            profileNftService: ProfileNftServiceImpl(
                networkClient: DefaultNetworkClient()
            ),
            profileService: servicesAssembly.profileService,
            sortService: ProfileSortService.shared
        )

        navigationController?.pushViewController(myNFTVC, animated: true)
    }

    func updateProfileDetails(profile: ProfileUIModel) {
        profileNameLabel.text = profile.name
        profileBioTextView.text = profile.description

        if let url = profile.website {
            let attributes: [NSAttributedString.Key: Any] = [
                .link: url,
                .font: UIFont.caption1
            ]

            let attributedString = NSMutableAttributedString(string: url.absoluteString,
                                                             attributes: attributes)
            profileLinkTextView.attributedText = attributedString
        }

        likedNftsCount = profile.likedNftsCount
        myNftsCount = profile.myNftsCount

        profileTableView.reloadData()
    }

    func updateProfileAvatar(avatar: URL?) {
        guard let avatar else { return }

        profileAvatar.kf.setImage(
            with: avatar,
            placeholder: UIImage.profileNoActive
        )
    }

}

// MARK: - ErrorView
extension ProfileViewController: ErrorView {

}

// MARK: - ProfileEditingPresenterDelegate
extension ProfileViewController: ProfileEditingPresenterDelegate {

    func profileDidUpdate() {
        presenter?.fetchProfile()
    }
}
