//
//  Repository.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/17/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Repository: Object, Codable {
    dynamic var id: Int = 0
    dynamic var fullName: String = ""
    dynamic var htmlUrl: String = ""
    dynamic var descriptionRep: String? = nil
    dynamic var updatedAt: String? = nil
    dynamic var stargazersCount: Int = 0
    dynamic var language: String? = nil
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", fullName = "full_name", htmlUrl = "html_url",
        descriptionRep = "description", updatedAt = "updated_at",
        stargazersCount = "stargazers_count", language = "language"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        fullName = try container.decode(String.self, forKey: .fullName)
        htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
        descriptionRep = try? container.decode(String.self, forKey: .descriptionRep)
        updatedAt = try? container.decode(String.self, forKey: .updatedAt)
        stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)
        language = try? container.decode(String.self, forKey: .language)
    }
    
    required init()
    {
        super.init()
    }
}
