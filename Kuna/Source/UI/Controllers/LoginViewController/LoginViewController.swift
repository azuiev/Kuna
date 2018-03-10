//
//  LoginViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 14/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

// MARK: Protocol ViewViewModel

extension LoginViewController: RootView {
    typealias ViewType = LoginView
}

class LoginViewController: ViewController<LoginViewModel> {
    
    // MARK: Initialization
    
    override init(_ viewModel: LoginViewModel) {
        super.init(viewModel)

        self.viewModel.loginResult
            .asObservable()
            .subscribe({
                _ = $0.map { [weak self] in
                    self?.check(response:$0) { [weak self] in
                        self?.parse(json: $0)
                    }
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        let view = self.rootView
        view?.fill(with: self.viewModel)
        
        view?.loginButton?.sendActions(for: .touchUpInside)
    }
    
    // MARK: Public Methods
    
    func parse(json: JSON) {
        let balances = LoginResponseParser().update(user: self.viewModel.currentUser, with: json)
        
        self.finishLogging(with: balances)
    }
    
    override func completeFail(with error: Error) {
        RealmService.shared.deleteObjectsWith(type: AccessTokenModel.self)
        
        super.completeFail(with: error)
    }
    
    // MARK: Private Methods
 
    private func finishLogging(with balances: BalancesModel) {
        let tabBarController = TabBarController(user: self.viewModel.currentUser, balances: balances)
        
        self.present(tabBarController, animated: true, completion: nil)
    }
}
