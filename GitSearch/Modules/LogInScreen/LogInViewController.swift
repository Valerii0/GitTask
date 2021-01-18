//
//  LogInViewController.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/16/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import UIKit
import WebKit

class LogInViewController: UIViewController, Storyboarded {
    
    var presenter: LogInPresenter!
    
    @IBOutlet var githubLoginBtn: UIButton!

    private var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
    }
    
    private func setUpButton() {
        githubLoginBtn.setTitle(Titles.login, for: .normal)
        githubLoginBtn.setTitleColor(.white, for: .normal)
        githubLoginBtn.layer.cornerRadius = 5
        githubLoginBtn.backgroundColor = .black
    }

    @IBAction func githubLoginBtnAction(_ sender: UIButton) {
        githubAuth()
    }
    
    private func githubAuth() {
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let urlRequest = URLRequest(url: URL(string: presenter.authURLFull())!)
        webView.load(urlRequest)

        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
        navigationItem.rightBarButtonItem = refreshButton
    }

    @objc func refreshAction() {
        self.webView.reload()
    }
}

extension LogInViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.RequestForCallbackURL(request: navigationAction.request)
        decisionHandler(.allow)
    }
    
    func RequestForCallbackURL(request: URLRequest) {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.contains(OAuthConstants.redirectUrl) {
            if requestURLString.contains("code=") {
                if let range = requestURLString.range(of: "=") {
                    let githubCode = requestURLString[range.upperBound...]
                    if let range = githubCode.range(of: "&state=") {
                        let githubCodeFinal = githubCode[..<range.lowerBound]
                        self.dismiss(animated: true, completion: nil)
                        presenter.saveToken(authCode: String(githubCodeFinal))
                    }
                }
            }
        }
    }
}

extension LogInViewController: LogInView {
}
