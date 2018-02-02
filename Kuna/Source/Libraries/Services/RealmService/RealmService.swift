//
//  RealmService.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 02/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RealmSwift

class RealmService {

    // MARK: Initialization
    
    static let shared = RealmService()
    
    private init() {}
    
    var realm = try! Realm()
    
    // MARK: Public Methods
    
    func get<T: Object>(_ object: T.Type) -> [T] {
        return Array(realm.objects(T.self))
    }
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    

}
