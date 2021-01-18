//
//  AccountManager.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/18/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import Foundation

final class AccountManager {
    static func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultsValue.token)
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsValue.token)
    }
    
    static func removeToken() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsValue.token)
    }
    
    static func stateToStart() -> State {
        if getToken() != nil {
            return State.app
        } else {
            return State.login
        }
    }
}
