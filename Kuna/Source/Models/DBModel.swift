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
    
    static func getObjectsWith<T: DBModel>(type: T.Type) -> [T] {
        return RealmService.shared.getObjectsWith(type: type)
    }
    
    static func deleteObjectsWith<T: DBModel>(type: T.Type) {
        RealmService.shared.deleteObjectsWith(type: type)
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
