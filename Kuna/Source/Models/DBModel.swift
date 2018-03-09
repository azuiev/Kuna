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
    
    // MARK: Public Methods
    
    func update(with dictionary: [String: Any?]) {
        RealmService.shared.update(self, with: dictionary)
    }
    
    func create() {
        RealmService.shared.create(self)
    }
    
    func delete() {
        RealmService.shared.delete(self)
    }
}
