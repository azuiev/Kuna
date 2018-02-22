    //
//  AppDelegate.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 04/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
 
        CurrencyModel.performLoading()
        MarketModel.performLoading()
        
        self.window?.perform {
            let controller = LoginViewController(LoginViewModel(CurrentUserModel(AccessTokenModel(publicKey: "", secretKey: ""))))
            
            $0.rootViewController = controller
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}

