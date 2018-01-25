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
                    self?.parse(response:$0)
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
    
    private func parse(response: Result<JSON>) {
        if response.isFailure() {
            _ = response.map {
                print($0)
            }
        } else {
            _ = response.map { [weak self] in
                self?.finish(with: $0)
            }
        }
    }
    
    private func finish(with result:JSON) {
        print(result)
        
        /*
        let tabBarController = UITabBarController()
        
        let names = ["My Balances", "Tradings", "My Orders", "History"]
        var controllers: [UIViewController] = []
        for item in names {
            let controller = BalancesViewController(BalancesViewModel())
            controller.title = item
            
            controllers.append(controller)
        }
        
        tabBarController.setViewControllers(controllers, animated: true)
        
        self.present(tabBarController, animated: true, completion: nil)
         */
    }
}
