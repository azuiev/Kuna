//
//  LoginViewModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 26/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel: ControllerViewModel {
    
    // MARK: Constants
    
    private enum Constants {
        static let tokenKey = "token"
    }
    // MARK: Public Properties
    
    let loginSubject = PublishSubject<Void>()
    let loginResult = PublishSubject<Result<JSON>>()
    
    // MARK: Private Properties
    
    private var isFirstLogin = true
    
    // MARK: UI Actions
    
    func onLogin(with token: AccessTokenModel) {
        if self.isFirstLogin {
            self.isFirstLogin = false
            let tokens = RealmService.shared.getObjectsWith(type: AccessTokenModel.self)
            for token in tokens {
                if token.publicKey != "" {
                    self.executeContext(with: [Constants.tokenKey: token])
                    
                    return
                }
            }

            self.loginSubject.onNext(())
        } else {
            self.executeContext(with: [Constants.tokenKey: token])
        }
    }
    
    // MARK: Private Methods
    
    private func executeContext(with dictionary: [String : Any]) {
        self.currentUser.update(with: dictionary)
        LoginContext(user: self.currentUser).execute(with: JSON.self) { [weak self] result, _ in
            self?.loginResult.onNext(result)
        }
    }
}
