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
    
    // MARK: Public Properties
    
    let loginSubject = PublishSubject<Void>()
    let loginResult = PublishSubject<Result<JSON>>()
    
    // MARK: Initialization
    
    override init(_ currentUserModel: CurrentUserModel) {
        super.init(currentUserModel)
    }
    
    // MARK: Private Properties
    
    private var isFirstLogin = true
    
    // MARK: UI Actions
    
    func onLogin(with token: AccessTokenModel) {
        if self.isFirstLogin {
            self.isFirstLogin = false
            
            if let user = RealmService.shared.getObjectsWith(type: CurrentUserModel.self).first {
                self.currentUser = user
                self.executeContext()
            } else {
                self.loginSubject.onNext(())
            }
        } else {
            let user = self.currentUser
            user.token = token
            
            self.executeContext()
        }
    }
    
    // MARK: Public Methods
    
    func saveUser() {
        self.currentUser.update()
    }
    
    // MARK: Private Methods
    
    private func executeContext() {
        LoginContext(user: self.currentUser).execute(with: JSON.self) { [weak self] in
            self?.loginResult.onNext($0)
        }
    }

}
