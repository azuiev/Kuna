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
        self.rootView?.fill(with: self.viewModel)
    }
    
    // MARK: Public Methods
    
    func parse(json: JSON) {
        let balances = LoginResponseParser().update(user: self.viewModel.currentUser, with: json)
        
        self.finishLogging(with: balances)
    }
    
    // MARK: Private Methods
 
    private func finishLogging(with balances:BalancesModel) {
        let balancesController = BalancesViewController(BalancesViewModel(user: self.viewModel.currentUser, balances: balances))
        balancesController.title = "My Balances"
        let tradingsController = TradingsViewController(TradingsViewModel(user: self.viewModel.currentUser, balances: balances))
        tradingsController.title = "Tradings"
        let ordersController = OrdersViewController(OrdersViewModel(user: self.viewModel.currentUser, orders: []))
        ordersController.title = "My Orders"
        let historyController = HistoryViewController(HistoryViewModel(user: self.viewModel.currentUser, orders: []))
        historyController.title = "History"
        
        let controllers = [balancesController, tradingsController, ordersController, historyController]

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(controllers, animated: true)
        
        self.present(tabBarController, animated: true, completion: nil)
    }
}
