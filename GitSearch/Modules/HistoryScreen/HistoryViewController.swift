//
//  HistoryViewController.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/16/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import UIKit
import SafariServices

class HistoryViewController: UIViewController, Storyboarded {

    @IBOutlet weak var historyTableView: UITableView!
    
    var presenter: HistoryPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.loadLocalRepositories()
    }
    
    private func setUpUI() {
        setUpView()
        setUpSearchingTableView()
    }
    
    private func setUpView() {
        self.navigationItem.title = Titles.history
    }
    
    private func setUpSearchingTableView() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.tableFooterView = UIView()
        historyTableView.register(UINib(nibName: RepositoryTableViewCell.identifier, bundle: nil),
                                  forCellReuseIdentifier: RepositoryTableViewCell.identifier)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
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
        let url = URL(string: presenter.repositories[indexPath.row].htmlUrl)
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }
}

extension HistoryViewController: HistoryView {
    func updateInfo() {
        DispatchQueue.main.async {
            self.historyTableView.reloadData()
        }
    }
}
