//
//  ProfilePresenter.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import Foundation

protocol ProfilePresenterProtocol {
    var profileView: ProfileViewControllerProtocol? { get set }

    func openAboutDeveloper()
    func viewDidLoad()
    func onMyNftsClicked()
    func onFavouriteNftsClicked()
    func onEditProfileClicked()
    func fetchProfile()
}

final class ProfilePresenter: ProfilePresenterProtocol {

    // MARK: - Properties
    weak var profileView: ProfileViewControllerProtocol?

    var loadedProfile: ProfileResponse?
    
    private let profileId: String

    private var profileService: ProfileService

    private var myNftsIds: [String] = []
    private var favouriteNftsIds: [String] = []

    // MARK: - Init
    init(
        service: ProfileService,
        profileId: String
    ) {
        profileService = service
        self.profileId = profileId
    }

    // MARK: - Methods
    func viewDidLoad() {
        fetchProfile()
    }

    func openAboutDeveloper() {
        guard let loadedProfile else { return }
        profileView?.openWebView(url: loadedProfile.website)
    }

    func onMyNftsClicked() {
        guard let loadedProfile else { return }

        profileView?.openMyNfts(profile: loadedProfile)
    }

    func onFavouriteNftsClicked() {
        guard let profile = loadedProfile else { return }
        
        profileView?.openFavouriteNfts(profile: profile)
    }

    func onEditProfileClicked() {
        guard let loadedProfile else { return }

        profileView?.openEditProfile(
            avatarUrl: loadedProfile.avatar,
            name: loadedProfile.name,
            description: loadedProfile.description,
            link: loadedProfile.website,
            likes: loadedProfile.likes
        )
    }

    func fetchProfile() {
        profileView?.setLoader(true)

        profileService.fetchProfile(id: profileId) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let profile):
                self.myNftsIds = profile.nfts
                self.favouriteNftsIds = profile.likes

                DispatchQueue.main.async {
                    self.loadedProfile = profile

                    let profileUiModel = ProfileUIModel(from: profile)

                    self.profileView?.updateProfileDetails(profile: profileUiModel)
                    self.profileView?.updateProfileAvatar(avatar: profile.avatar)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.profileView?.showError(self.checkError(error))
                }

                print("Error fetching profile: \(error)")
            }

            DispatchQueue.main.async {
                self.profileView?.setLoader(false)
            }
        }
    }

    private func checkError(_ error: Error) -> ErrorModel {
        let message: String
        switch error {
        case is NetworkClientError:
            message = NSLocalizedString("Error.network", comment: "")
        default:
            message = NSLocalizedString("Error.unknown", comment: "")
        }

        let actionText = NSLocalizedString("Error.repeat", comment: "")
        return ErrorModel(message: message, actionText: actionText) { [weak self] in
            self?.fetchProfile()
        }
    }
}

// MARK: ProfileServiceDelegate
extension ProfilePresenter: ProfileServiceDelegate {

    func profileDidUpdate(profile: ProfileResponse) {
        fetchProfile()
    }
}
