//
//  LogInPresenter.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/16/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import Foundation

protocol LogInView: class {
}

class LogInPresenter {
    private weak var view: LogInView?
    private var coordinator: MainCoordinator?

    init(view: LogInView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func authURLFull() -> String{
        return "https://github.com/login/oauth/authorize?client_id=" + OAuthConstants.clientId + "&scope=" + OAuthConstants.scope + "&redirect_uri=" + OAuthConstants.redirectUrl + "&state=" + UUID().uuidString
    }
    
    func saveToken(authCode: String) {
        GithubRequestService.githubRequestForAccessToken(authCode: authCode) { (token) in
            AccountManager.setToken(token: token)
            
            DispatchQueue.main.async {
                self.coordinator?.configure()
            }
        }
    }
}
