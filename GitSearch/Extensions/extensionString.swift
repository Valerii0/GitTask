//
//  extensionString.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/18/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        if let date: Date = dateFormatterGet.date(from: self) {
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
