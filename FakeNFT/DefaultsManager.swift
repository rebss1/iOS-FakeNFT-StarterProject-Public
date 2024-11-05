//
//  DefaultsManager.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 21.10.2024.
//

import Foundation

final class DefaultsManager {
    private let defaults = UserDefaults.standard
    
    public func saveObject(value: Any,
                           for key: DefaultsKeys) {
        defaults.set(value,
            forKey: key.rawValue)
    }
    
    public func fetchObject<T>(type: T.Type,
                               for key: DefaultsKeys) ->T? {
        return defaults.object(forKey: key.rawValue) as? T
    }
}

enum DefaultsKeys: String {
    case sortType
}
