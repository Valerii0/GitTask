//
//  Storyboarded.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/16/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(storyboardName name: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    /// Create storyboardController from Class
    static func instantiate(storyboardName name: String) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
