//
//  ProfileEditViewController.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 16.10.2024.
//

import Foundation

protocol ProfileEditingPresenterProtocol {
    
    var view: ProfileEditingViewControllerProtocol? { get set }
    
    func updateProfile()
}

final class ProfileEditingPresenter: ProfileEditingPresenterProtocol {
    
    weak var view: ProfileEditingViewControllerProtocol?
    
    private let initAvatarUrl: URL?
    private let initName: String
    private let initDescription: String
    private let initWebsite: URL?
    
    init(view: ProfileEditingViewControllerProtocol, initAvatarUrl: URL?, initName: String, initDescription: String, website: URL?) {
        self.view = view
        self.initAvatarUrl = initAvatarUrl
        self.initName = initName
        self.initDescription = initDescription
        self.initWebsite = website
    }
    
    func updateProfile() {
        view?.updateTitles(
            profileName: initName,
            profileBio: initDescription,
            profileWebLink: initWebsite,
            avatar: initAvatarUrl
        )
    }
    
}
