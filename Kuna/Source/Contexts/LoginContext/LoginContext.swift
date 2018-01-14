//
//  LoginContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginContext: GetContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let TokenStringPath     = "token.tokenString"
        static let UserIDStringPath    = "token.userID"
        static let UserIDString        = "userID"
        static let TokenString         = "token"
    }
    
    // MARK: Initialization
    
    init(currentUser: Model, subject: PublishSubject<Result<Model>>) {
        self.subject = subject
        
        super.init(model: currentUser, currentUser: currentUser)
    }
    
    // MARK: Public Methods
    
    override func execute(withCompletion completionHandler: @escaping(ModelState) -> Void) {

    }
    
    // MARK: Private Properties
    
    var subject: PublishSubject<Result<Model>>
}
