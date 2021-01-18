//
//  GithubRequestService.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/17/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import Foundation

final class GithubRequestService {
    static func githubRequestForAccessToken(authCode: String, callBack: @escaping (_ accessToken: String) -> Void) {
        let postParams = "grant_type=" + OAuthConstants.authorizationCode + "&code=" + authCode + "&client_id=" + OAuthConstants.clientId + "&client_secret=" + OAuthConstants.clientSecret
        let postData = postParams.data(using: String.Encoding.utf8)
        let request = NSMutableURLRequest(url: URL(string: OAuthConstants.tokenUrl)!)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                let results = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                let accessToken = results?["access_token"] as! String
                
                callBack(accessToken)
            }
        }
        task.resume()
    }
    
    static func getRepositories(query: String, page: Int, perPage: Int, sort: String, callBack: @escaping (_ repositoriesSearchResult: RepositoriesSearchResult?, _ error: Error?) -> Void) {
        let urlString = Api.url + Api.repositories
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)"),
            URLQueryItem(name: "sort", value: sort)
        ]
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.setValue("Bearer \(AccountManager.getToken() ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                callBack(nil, error)
            } else if let data = data {
                do {
                    let repositoriesSearchResult = try JSONDecoder().decode(RepositoriesSearchResult.self, from: data)
                    callBack(repositoriesSearchResult, nil)
                } catch {
                    callBack(nil, error)
                }
            }
        }
        task.resume()
    }
}
