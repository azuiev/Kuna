//
//  TradingsResponseParser.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class TradingsResponseParser {
    
    // MARK: Constants
    
    private struct Constants {
        static let bidsKey          = "bids"
        static let asksKey          = "asks"
        
        static let currenciesKey    = "accounts"
        static let currencyKey      = "currency"
        static let balanceKey       = "balance"
        static let lockedBalanceKey = "locked"
    }
    
    // MARK: Public Methods
    
    func update(tradings: BalancesModel, with json: JSON) -> BalancesModel {
        if let bids = json[Constants.bidsKey] as? JSONArray {
            print(bids)
        }
        
        if let asks = json[Constants.asksKey] as? JSONArray {
            print(asks)
        }
        
        let balances = BalancesModel(array: [BalanceModel]())
        
        if let currenciesJSON = json[Constants.currenciesKey] as? JSONArray {
            for currencyJSON in currenciesJSON {
                if let currencyCode = currencyJSON[Constants.currencyKey] as? String {
                    let currency = CurrencyModel.currencyWith(code: currencyCode)
                    let balance = BalanceModel(currency: currency)
                    
                    if let count = currencyJSON[Constants.balanceKey] as? String {
                        Double(count).map {
                            balance.count = $0
                        }
                    }
                    
                    if let locked = currencyJSON[Constants.lockedBalanceKey] as? String {
                        Double(locked).map {
                            balance.locked = $0
                        }
                    }
                    
                    balances.add(object: balance)
                }
            }
        }
        
        return tradings
    }
    
    func createAndUpdateTradingsWith(json: JSON) -> BalancesModel {
        let tradings = BalancesModel(array: [BalanceModel]())
        _ = self.update(tradings: tradings, with: json)
        
        return tradings
    }
}
