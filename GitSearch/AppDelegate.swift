//
//  AppDelegate.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/16/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        coordinator = MainCoordinator()
        coordinator?.configure()
        
        return true
    }
}
