//
//  LoginViewModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 26/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel: ViewModel {
    
    // MARK: Public Properties
    
    let loginResult = PublishSubject<Result<JSON>>()
    
    // MARK: UI Actions
    
    func onLogin(with token: AccessTokenModel) {
        self.currentUser.token = token
        
        LoginContext(token: token).execute(with: JSON.self) { [weak self] in
            self?.loginResult.onNext($0)
        }
    }
}
