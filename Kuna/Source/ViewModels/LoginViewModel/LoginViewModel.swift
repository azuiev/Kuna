//
//  LoginViewModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 26/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    // MARK: Public Properties
    
    let disposeBag = DisposeBag()
    let loginResult = PublishSubject<Result<JSON>>()
    
    // MARK: Initialization
    
    init(_ currentUserModel: Model) {
        self.currentUser = currentUserModel
    }
    
    // MARK: Public Functions
    
    func onLogin(with token: AccessTokenModel) {
        LoginContext(token: token).execute { [weak self] in
            self?.loginResult.onNext($0)
        }
    }
    
    // MARK: Private Properties
    
    private var currentUser: Model
}
