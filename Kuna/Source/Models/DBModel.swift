//
//  Model.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 25/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RealmSwift

class DBModel: Object {
    
    // MARK: Class Methods
    
    static func loadObjects<T: DBModel>(type: T.Type) -> [T] {
        let result = RealmService.shared.get(T.self)
        print(result)
        
        return result
    }
    
    static func deleteAll() {
        RealmService.shared.deleteAll()
    }
    
    // MARK: Public Methods
    
    func update() {
        RealmService.shared.update(self)
    }
    
    func create() {
        RealmService.shared.create(self)
    }
    
    func delete() {
        RealmService.shared.delete(self)
    }
}
