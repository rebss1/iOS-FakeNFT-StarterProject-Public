//
//  ProfileSortService.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 30.10.2024.
//

import Foundation

enum MyNFTSortType: String {
    case price
    case rating
    case name
}

protocol ProfileSortServiceProtocol {
    
    var sort: MyNFTSortType { get set }
    
}

class ProfileSortService: ProfileSortServiceProtocol {
    
    static let shared = ProfileSortService()
    
    private static let sortingPreferenceKey = "sortingPreference"

    var sort: MyNFTSortType {
        get {
            let strValue = UserDefaults.standard.string(forKey: ProfileSortService.sortingPreferenceKey)
            
            if let strValue {
                return MyNFTSortType(rawValue: strValue) ?? MyNFTSortType.rating
            } else {
                return MyNFTSortType.rating
            }
        }
        
        set {
            UserDefaults.standard.set(
                newValue.rawValue,
                forKey: ProfileSortService.sortingPreferenceKey
            )
        }
    }
    
    private init () {}
}
