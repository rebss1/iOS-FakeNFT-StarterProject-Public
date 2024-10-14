//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    let servicesAssembly: ServicesAssembly

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
