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
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var profileView: ProfileViewControllerProtocol?
    
    func openAboutDeveloper() {
        profileView?.openWebView(url: ProfileConstants.developerLink)
    }
}

enum ProfileConstants {
    static let profileNameString = "Joaquin Phoenix"
    static let profileBioString = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
    static let profileWebLinkString = "Joaquin Phoenix.com"
    static let developerLink = "https://phoenix.com"
}
