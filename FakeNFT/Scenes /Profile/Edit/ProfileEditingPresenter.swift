//
//  ProfileEditingPresenter.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import Foundation

protocol ProfileEditingPresenterProtocol {
    
    var view: ProfileEditingViewControllerProtocol? { get set }
    
    func udateProfile()
}

final class ProfileEditingPresenter: ProfileEditingPresenterProtocol {
    
    weak var view: ProfileEditingViewControllerProtocol?
    
    func udateProfile() {
        let profileName = ProfileConstants.profileNameString
        let profileBio = ProfileConstants.profileBioString
        let profileWebLink = ProfileConstants.profileWebLinkString
        
        view?.updateTitles(profileName: profileName, profileBio: profileBio, profileWebLink: profileWebLink)
    }
    
}
