//
//  RepositoriesSearchResult.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/17/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import Foundation

class RepositoriesSearchResult: Codable {
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [Repository]?
}
