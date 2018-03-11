//
//  RealmService.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 02/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

class RealmService {

    // MARK: Public Properties
    
    var realm = try! Realm()
    let dbErrorSubject = PublishSubject<Error>()
    
    // MARK: Initialization
    
    static let shared = RealmService()
    
    private init() {}
    
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
            notify(with: error)
        }
    }
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: true)
            }
        } catch {
            notify(with: error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            notify(with: error)
        }
    }
    
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            notify(with: error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                realm.add(object, update: true)
                
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print(error)
        }
    }
    
    // MARK Private Methods
    
    private func notify(with error: Error) {
        self.dbErrorSubject.onNext(error)
    }
}
