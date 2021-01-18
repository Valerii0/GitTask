//
//  MainCoordinator.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/16/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import UIKit

protocol Coordinatable {
    var tabBarController: UITabBarController { get set }
}

final class MainCoordinator: Coordinatable {
    var window: UIWindow
    var tabBarController: UITabBarController
    
    private enum StoryboardsName: String {
        case logIn = "LogIn"
        case searching = "Searching"
        case history = "History"
    }
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.tabBarController = UITabBarController()
    }
    
    func configure() {
        let state = AccountManager.stateToStart()
        switch state {
        case .login:
            self.makeLogInRoot()
        case .app:
            self.makeTabBarRoot()
        }
    }
    
    func makeLogInRoot() {
        window.rootViewController = logInViewController()
    }
    
    func makeTabBarRoot() {
        window.rootViewController = tabBarController
        tabBarController.viewControllers = [
            searchingViewController(),
            historyViewController()
        ]
        tabBarController.selectedIndex = 0
    }
    
    func logInViewController() -> UINavigationController {
        let viewController = LogInViewController.instantiate(storyboardName: StoryboardsName.logIn.rawValue)
        let configurator = LogInConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
    func searchingViewController() -> UINavigationController {
        let viewController = SearchingViewController.instantiate(storyboardName: StoryboardsName.searching.rawValue)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let configurator = SearchingConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
    func historyViewController() -> UINavigationController {
        let viewController = HistoryViewController.instantiate(storyboardName: StoryboardsName.history.rawValue)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        let configurator = HistoryConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        return navigationController
    }
}
