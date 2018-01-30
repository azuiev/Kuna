//
//  LoginViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 14/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
    
    // MARK: Private Methods
    
    private func check(result: Result<JSON>) {
        if result.isFailure() {
            _ = result.map {
                print($0)
            }
        } else {
            _ = result.map { [weak self] in
                self?.parse(json: $0)
            }
        }
    }
    
    private func parse(json: JSON) {
        let balances = CurrentUserParser().update(user: self.viewModel.currentUser, with: json)
        
        self.finishLogging(with: balances)
    }
    
    private func finishLogging(with balances:BalancesModel) {
        
        let tabBarController = UITabBarController()
        
        let names = ["My Balances", "Tradings", "My Orders", "History"]
        var controllers: [UIViewController] = []
        for item in names {
            let controller = BalancesViewController(BalancesViewModel(user: self.viewModel.currentUser, balances: balances))
            controller.title = item
            
            controllers.append(controller)
        }
        
        tabBarController.setViewControllers(controllers, animated: true)
        
        self.present(tabBarController, animated: true, completion: nil)
        
    }
}
