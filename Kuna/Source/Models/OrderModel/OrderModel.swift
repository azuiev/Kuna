//
//  OrderModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 18/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class OrderModel: DBModel {
    
    // MARK: Public Properties
    
    dynamic var id: Int = 0
    dynamic var price: Double = 0.0
    dynamic var volumeMain: Double = 0.0
    dynamic var market: String = ""
    dynamic var createdTime: Date = Date()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
