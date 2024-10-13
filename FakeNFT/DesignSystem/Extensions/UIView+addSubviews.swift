//
//  UIView+addSubviews.swift
//  Tracker
//
//  Created by Илья Лощилов on 14.06.2024.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(_
                     subviews: [UIView]) {
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
