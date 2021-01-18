//
//  SearchingViewController.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/16/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import UIKit
import SafariServices

class SearchingViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var searchingTextField: UITextField!
    @IBOutlet weak var searchingTableView: UITableView!
    
    var presenter: SearchingPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        hideKeyboardWhenTappedAround()
        searchingTextField.addTarget(self, action: #selector(searchingTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setUpUI() {
        setUpView()
        setUpSearchingTableView()
    }
    
    private func setUpView() {
        self.navigationItem.title = Titles.searching
    }
    
    private func setUpSearchingTableView() {
        searchingTableView.delegate = self
        searchingTableView.dataSource = self
        searchingTableView.tableFooterView = UIView()
        searchingTableView.register(UINib(nibName: RepositoryTableViewCell.identifier, bundle: nil),
                                    forCellReuseIdentifier: RepositoryTableViewCell.identifier)
    }
    
    @objc func searchingTextFieldDidChange(_ textField: UITextField) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(makeFirstRequest), object: nil)
        
        perform(#selector(makeFirstRequest), with: nil, afterDelay: 1.0)
    }
    
    @objc func makeFirstRequest() {
        presenter.loadRepositories(query: searchingTextField.text, loadType: .firstLoad)
    }
}

extension SearchingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as! RepositoryTableViewCell
        cell.configure(repository: presenter.repositories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.saveRepository(index: indexPath.row)
        let url = URL(string: presenter.repositories[indexPath.row].htmlUrl)
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.repositories.count - 1 && presenter.canLoadMore && !presenter.isLoading {
            presenter.loadRepositories(query: searchingTextField.text, loadType: .paginationsLoad)
        }
    }
}

extension SearchingViewController: SearchingView {
    func reloadRepositories() {
        DispatchQueue.main.async {
            self.searchingTableView.reloadData()
        }
    }
}
