//
//  TabBarController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/03/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: Constants
    
    private enum Constants {
        static let balancesTitle            = "My Balances"
        static let balancesImage            = "rmc"
        static let tradingsTitle            = "Tradings"
        static let tradingsImage            = "evr"
        static let ordersTitle              = "My Orders"
        static let ordersImage              = "eth"
        static let historyTitle             = "History"
        static let historyImage             = "arrow"
    }
    
    // MARK: Private Properties
    
    private var currentUser: CurrentUserModel?
    private var balances: BalancesModel?
    
    // MARK: Initialization
    
    convenience init(user: CurrentUserModel, balances: BalancesModel) {
        self.init()
        
        self.currentUser = user
        self.balances = balances
    }
    
    // MARK: View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = self.currentUser,
            let balances = self.balances else { return }
        
        let balancesController = BalancesViewController(BalancesViewModel(user: user, balances: balances))
        let balanceImage = UIImage(named: Constants.balancesImage)
        balancesController.tabBarItem = UITabBarItem(title: Constants.balancesTitle,
                                                     image: balanceImage,
                                                     selectedImage: balanceImage)
        
        
        let tradingsController = TradingsViewController(TradingsViewModel(user))
        let tradingsImage = UIImage(named: Constants.tradingsImage)
        tradingsController.tabBarItem = UITabBarItem(title: Constants.tradingsTitle,
                                                     image: tradingsImage,
                                                     selectedImage: tradingsImage)
        
        let ordersController = OrdersViewController(OrdersViewModel(user))
        let ordersImage = UIImage(named: Constants.ordersImage)
        ordersController.tabBarItem = UITabBarItem(title: Constants.ordersTitle,
                                                   image: ordersImage,
                                                   selectedImage: ordersImage)
        
        let historyController = HistoryViewController(HistoryViewModel(user))
        let historyImage = UIImage(named: Constants.historyImage)
        historyController.tabBarItem = UITabBarItem(title: Constants.historyTitle,
                                                    image: historyImage,
                                                    selectedImage: historyImage)
        
        self.viewControllers = [balancesController, tradingsController, ordersController, historyController]
    }
}
