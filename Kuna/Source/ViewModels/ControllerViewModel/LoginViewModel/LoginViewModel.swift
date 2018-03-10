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
            
            if let token = RealmService.shared.getObjectsWith(type: AccessTokenModel.self).last {
                self.currentUser.update(with: [Constants.tokenKey: token])
                self.executeContext()
            } else {
                self.loginSubject.onNext(())
            }
        } else {
            self.currentUser.update(with: [Constants.tokenKey: token])
            self.executeContext()
        }
    }
    
    // MARK: Private Methods
    
    private func executeContext() {
        LoginContext(user: self.currentUser).execute(with: JSON.self) { [weak self] result, _ in
            self?.loginResult.onNext(result)
        }
    }
}
