//
//  AccessTokenModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 19/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class AccessTokenModel {

    //MARK: Public Properties
    
    var publicKey: String
    var secretKey: String
    
    // MARK: Initialization
    
    init(publicKey: String?, secretKey: String?) {
        self.publicKey = publicKey ?? ""
        self.secretKey = secretKey ?? ""
    }
}
