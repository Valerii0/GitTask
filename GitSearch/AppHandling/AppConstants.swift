//
//  AppConstants.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/17/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import Foundation

enum State {
    case login
    case app
}

struct UserDefaultsValue {
    static let token = "token"
}

struct Api {
    static let url = "https://api.github.com"
    static let repositories = "/search/repositories"
    static let user = "/user"
}

struct OAuthConstants {
    static let clientId = "d49e66807193b4363f62"
    static let clientSecret = "ae9c8763c60935e9db771f8d98e5301d793f5635"
    static let redirectUrl = "https://github.com/Valerii0/GitSearch"
    static let scope = "read:user,user:email"
    static let tokenUrl = "https://github.com/login/oauth/access_token"
    static let authorizationCode = "authorization_code"
}

struct AssetsConstants {
    static let star = "star"
    static let book = "book"
}

struct SearchConstants {
    static let sortType = "stars"
    static let countPerPage = 15
}

struct Titles {
    static let login = "Log in with Github"
    static let github = "github.com"
    static let searching = "Searching"
    static let history = "History"
}
