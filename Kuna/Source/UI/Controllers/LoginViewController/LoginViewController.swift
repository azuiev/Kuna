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

extension LoginViewController: ViewViewModel {
    typealias ViewType = LoginView
    typealias ViewModelType = LoginViewModel
}

class LoginViewController: ViewController {
    
    // MARK: Initialization
    
    init(_ viewModel: LoginViewModel) {
        super.init(viewModel)

        self.mainViewModel.loginResult
            .asObservable()
            .subscribe({
                _ = $0.map { [weak self] in
                    self?.check(response:$0) { [weak self] in
                        self?.parse(json: $0)
                    }
                }
            })
            .disposed(by: self.mainViewModel.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        self.rootView?.fill(with: self.mainViewModel)
    }
    
    // MARK: Public Methods
    
    func parse(json: JSON) {
        let balances = LoginResponseParser().update(user: self.mainViewModel.currentUser, with: json)
        
        self.finishLogging(with: balances)
    }
    
    // MARK: Private Methods
 
    private func finishLogging(with balances:BalancesModel) {
        
        let tabBarController = UITabBarController()
        
        let names = ["My Balances", "Tradings", "My Orders", "History"]
        var controllers: [UIViewController] = []
        var controller = UIViewController()
        for item in names {
            if item == "Tradings" {
                controller = TradingsViewController(TradingsViewModel(user: self.mainViewModel.currentUser, balances: balances))
            } else {
                controller = BalancesViewController(BalancesViewModel(user: self.mainViewModel.currentUser, balances: balances))
            }
            controller.title = item
            
            controllers.append(controller)
        }
        
        tabBarController.setViewControllers(controllers, animated: true)
        
        self.present(tabBarController, animated: true, completion: nil)
        
    }
}
