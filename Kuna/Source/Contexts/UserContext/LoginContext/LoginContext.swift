//
//  LoginContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 17/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class LoginContext: UserContext {
    
    // MARK: Private Properties
    
    override var urlPath: String { return "api/v2/members/me" }
}
