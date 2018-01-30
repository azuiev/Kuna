//
//  CurrentUserParser.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 28/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class CurrentUserParser {
    
    // MARK: Constants
    
    private struct Constants {
        static let activatedKey     = "activated"
        static let emailKey         = "email"
        static let currenciesKey    = "accounts"
        static let currencyKey      = "currency"
        static let balanceKey       = "accounts"
        static let lockedBalanceKey = "locked"
    }
    
    // MARK: Public Methods
    
    func update(user: CurrentUserModel, with json: JSON) -> BalancesModel {
        if let state = json[Constants.activatedKey] as? Bool {
            user.activated = state
        }
        
        if let email = json[Constants.emailKey] as? String {
            user.email = email
        }
        
        let balances = BalancesModel(array: [BalanceModel]())
        
        if let currenciesJSON = json[Constants.currenciesKey] as? JSONArray {
            for currencyJSON in currenciesJSON {
                if let currencyCode = currencyJSON[Constants.currencyKey] as? String {
                    let currency = CurrencyModel.currencyWith(code: currencyCode)
                    let balance = BalanceModel(currency: currency)
                    
                    if let count = currencyJSON[Constants.balanceKey] as? Double {
                        balance.count = count
                    }
                    
                    if let locked = currencyJSON[Constants.lockedBalanceKey] as? Double {
                        balance.locked = locked
                    }
                    
                    balances.add(object: balance)
                }
            }
        }
        
        return balances
    }
    
    func createAndUpdateUserWith(token: AccessTokenModel, json: JSON) -> CurrentUserModel{
        let user = CurrentUserModel(token)
        _ = self.update(user: user, with: json)
        
        return user
        
    }
}
