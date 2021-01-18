//
//  HistoryPresenter.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/16/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import Foundation

protocol HistoryView: class {
    func updateInfo()
}

class HistoryPresenter {
    private weak var view: HistoryView?
    private var coordinator: MainCoordinator?
    var repositories = [Repository]()

    init(view: HistoryView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func loadLocalRepositories() {
        repositories = RealmManager.getRepositoriesFromRealm().reversed()
        view?.updateInfo()
    }
}
