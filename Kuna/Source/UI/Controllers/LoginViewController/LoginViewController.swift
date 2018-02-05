//
//  LoginViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 14/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {

    // MARK: Public Properties
    
    var viewModel: LoginViewModel
    
    var rootView: LoginView? {
        return self.viewIfLoaded as? LoginView
    }
    
    // MARK: Initialization
    
    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: toString(type(of: self)), bundle: .main)
        
        self.viewModel.loginResult
            .asObservable()
            .subscribe({
                _ = $0.map { [weak self] in
                    self?.check(result:$0)
                }
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        self.rootView?.fill(with: self.viewModel)
    }
    
    // MARK: Public Methods
    
    override func parse(json: JSON) {
        let balances = LoginResponseParser().update(user: self.viewModel.currentUser, with: json)
        
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
                controller = TradingsViewController(TradingsViewModel(user: self.viewModel.currentUser, balances: balances))
            } else {
                controller = BalancesViewController(BalancesViewModel(user: self.viewModel.currentUser, balances: balances))
            }
            controller.title = item
            
            controllers.append(controller)
        }
        
        tabBarController.setViewControllers(controllers, animated: true)
        
        self.present(tabBarController, animated: true, completion: nil)
        
    }
}
