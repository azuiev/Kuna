//
//  AccessTokenModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 19/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class AccessTokenModel: DBModel {

    //MARK: Public Properties
    
    dynamic var publicKey: String = ""
    dynamic var secretKey: String = ""
    
    // MARK: Initialization
    
    convenience init(publicKey: String?, secretKey: String?) {
        self.init()
        
        self.publicKey = publicKey ?? ""
        self.secretKey = secretKey ?? ""
    }
}
