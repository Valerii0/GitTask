//
//  Configurator.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/16/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

protocol LogInConfigurable {
    func configure(viewController: LogInViewController, coordinator: MainCoordinator)
}

class LogInConfigurator: LogInConfigurable {
    func configure(viewController: LogInViewController, coordinator: MainCoordinator) {
        let logInPresenter = LogInPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = logInPresenter
    }
}

protocol SearchingConfigurable {
    func configure(viewController: SearchingViewController, coordinator: MainCoordinator)
}

class SearchingConfigurator: SearchingConfigurable {
    func configure(viewController: SearchingViewController, coordinator: MainCoordinator) {
        let searchingPresenter = SearchingPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = searchingPresenter
    }
}

protocol HistoryConfigurable {
    func configure(viewController: HistoryViewController, coordinator: MainCoordinator)
}

class HistoryConfigurator: HistoryConfigurable {
    func configure(viewController: HistoryViewController, coordinator: MainCoordinator) {
        let historyPresenter = HistoryPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = historyPresenter
    }
}
