//
//  UIViewController+wrapWithNavigationController.swift
//  Tracker
//
//  Created by Илья Лощилов on 27.06.2024.
//

import UIKit

extension UIViewController {
    
    func wrapWithNavigationController() -> UINavigationController {
        UINavigationController(rootViewController: self)
    }
}
