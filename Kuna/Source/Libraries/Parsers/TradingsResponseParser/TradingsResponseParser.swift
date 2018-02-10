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
        
        return tradings
    }
    
    func createAndUpdateTradingsWith(json: JSON) -> BalancesModel {
        let tradings = BalancesModel(array: [BalanceModel]())
        _ = self.update(tradings: tradings, with: json)
        
        return tradings
    }
}
