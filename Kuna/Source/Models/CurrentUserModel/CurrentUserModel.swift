//
//  CurrentUserModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 28/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RxSwift

@objcMembers class CurrentUserModel: DBModel {
    
    // MARK: Public Properties
    
    dynamic var id: Int                     = 0
    dynamic var token: AccessTokenModel?    = nil
    dynamic var activated: Bool             = false
    dynamic var email: String               = ""
  
    // MARK: Initialization
    
    convenience init(_ token: AccessTokenModel) {
        self.init()

        self.token = token
    }
    
    // MARK: Realm PrimaryKey
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
