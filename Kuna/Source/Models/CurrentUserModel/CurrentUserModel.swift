//
//  CurrentUserModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 28/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class CurrentUserModel {
    
    // MARK: Public Properties
    
    var email: String?
    var activated: Bool = false
    var token: AccessTokenModel
    
    init(_ token: AccessTokenModel) {
        self.token = token
    }
}
