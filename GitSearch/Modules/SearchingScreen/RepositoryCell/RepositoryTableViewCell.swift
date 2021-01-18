//
//  RepositoryTableViewCell.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/17/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    static let identifier = "RepositoryTableViewCell"

    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var programmingLanguageLabel: UILabel!
    @IBOutlet weak var updatedOnLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        setUpImageViews()
        setUpLabels()
    }
    
    private func setUpImageViews() {
        repositoryImageView.image = UIImage(named: AssetsConstants.book)?.withRenderingMode(.alwaysTemplate)
        repositoryImageView.tintColor = .darkGray
        starImageView.image = UIImage(named: AssetsConstants.star)?.withTintColor(.gray, renderingMode: .alwaysTemplate)
        starImageView.tintColor = .darkGray
    }
    
    private func setUpLabels() {
        setUpRepositoryNameLabel()
        setUpDescriptionLabel()
        starCountLabel.textColor = .gray
        programmingLanguageLabel.textColor = .gray
        updatedOnLabel.textColor = .gray
    }
    
    private func setUpRepositoryNameLabel() {
        repositoryNameLabel.textAlignment = .left
        repositoryNameLabel.textColor = .blue
        repositoryNameLabel.numberOfLines = 1
    }
    
    private func setUpDescriptionLabel() {
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 5
    }
    
    func configure(repository: Repository) {
        repositoryNameLabel.text = repository.fullName
        descriptionLabel.text = repository.descriptionRep
        starCountLabel.text = "\(repository.stargazersCount)"
        programmingLanguageLabel.text = repository.language
        if let updatedAt = repository.updatedAt {
            updatedOnLabel.text = updatedAt.toDate()
        }
    }
}
