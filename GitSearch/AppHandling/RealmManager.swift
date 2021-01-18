//
//  RealmManager.swift
//  GitSearch
//
//  Created by Valerii Petrychenko on 1/18/21.
//  Copyright © 2021 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class RealmManager {
    static func getRepositoriesFromRealm() -> [Repository] {
        do {
            let realm = try Realm()
            let repositories = realm.objects(Repository.self)
            return Array(repositories)
        } catch {
            print(error.localizedDescription)
        }
        return [Repository]()
    }
    
    static func saveRepositoryToRealm(repository: Repository) {
        do {
            let realm = try Realm()
            do {
                try realm.write {
                    realm.add(repository)
                }
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
