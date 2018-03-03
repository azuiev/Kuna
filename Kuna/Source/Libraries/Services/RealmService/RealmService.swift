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
    
    func getObjectsWith<T: Object>(type: T.Type, filter: NSPredicate? = nil) -> [T] {
        if let unwrappedFilter = filter {
            return Array(realm.objects(type).filter(unwrappedFilter))
        }
 
        return Array(realm.objects(type))
    }
    
    func deleteObjectsWith<T: Object>(type: T.Type, filter: NSPredicate? = nil) {
        var objectsToDelete = realm.objects(type)
        if let unwrappedFilter = filter {
            objectsToDelete = objectsToDelete.filter(unwrappedFilter)
        }
        do {
            try realm.write {
                realm.delete(objectsToDelete)
            }
        } catch {
            print(error)
        }
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
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
    func update<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: true)
            }
        } catch {
            print(error)
        }
    }
}
