//
//  SearchingPresenter.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/16/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import Foundation

enum ThreadName {
    case first
    case second
    
    static let allValues: [ThreadName] = [.first, .second]
}

enum LoadType {
    case firstLoad
    case paginationsLoad
}

protocol SearchingView: class {
    func reloadRepositories()
}

class SearchingPresenter {
    private weak var view: SearchingView?
    private var coordinator: MainCoordinator?
    var repositories = [Repository]()
    private var firstThreadRepositories = [Repository]()
    private var secondThreadRepositories = [Repository]()
    private var totalCountToLoad = 0
    var canLoadMore: Bool {
        repositories.count < totalCountToLoad
    }
    var isLoading = false

    init(view: SearchingView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func saveRepository(index: Int) {
        RealmManager.saveRepositoryToRealm(repository: repositories[index])
    }
    
    func loadRepositories(query: String?, loadType: LoadType) {
        firstThreadRepositories.removeAll()
        secondThreadRepositories.removeAll()
        if let query = query, query.count > 0 {
            switch loadType {
            case .firstLoad:
                repositories.removeAll()
                performParallelLoad(query: query)
            case .paginationsLoad:
                performParallelLoad(query: query)
            }
        } else {
            repositories.removeAll()
            view?.reloadRepositories()
        }
    }
    
    private func performParallelLoad(query: String) {
        isLoading = true
        let group = DispatchGroup()
        let page: Int = (repositories.count / SearchConstants.countPerPage) + 1
        getRepositories(query: query, page: page, group: group, threadName: .first)
        getRepositories(query: query, page: page + 1, group: group, threadName: .second)
        group.notify(queue: .global()) { [weak self] in
            guard let self = self else { return }
            for threadName in ThreadName.allValues {
                switch threadName {
                case .first:
                    self.repositories.append(contentsOf: self.firstThreadRepositories)
                case .second:
                    self.repositories.append(contentsOf: self.secondThreadRepositories)
                }
            }
            self.view?.reloadRepositories()
            self.isLoading = false
        }
    }
    
    private func getRepositories(query: String, page: Int, group: DispatchGroup, threadName: ThreadName) {
        group.enter()
        GithubRequestService.getRepositories(query: query, page: page, perPage: SearchConstants.countPerPage, sort: SearchConstants.sortType) { [weak self] (repositoriesSearchResult, error) in
            if let repositories = repositoriesSearchResult?.items, let totalCount = repositoriesSearchResult?.total_count {
                self?.totalCountToLoad = totalCount
                switch threadName {
                case .first:
                    self?.firstThreadRepositories = repositories
                case .second:
                    self?.secondThreadRepositories = repositories
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            group.leave()
        }
    }
}
