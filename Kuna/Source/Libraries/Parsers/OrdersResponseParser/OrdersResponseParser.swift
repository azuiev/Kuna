//
//  OrdersResponseParser.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class OrdersResponseParser {
    
    // MARK: Constants
    
    private struct Constants {
        static let bidsKey              = "bids"
        static let asksKey              = "asks"
        static let idKey                = "id"
        static let sideKey              = "side"
        static let typeKey              = "ord_type"
        static let priceKey             = "price"
        static let averagePriceKey      = "avg_price"
        static let stateKey             = "state"
        static let marketKey            = "market"
        static let dateKey              = "created_at"
        static let volumeKey            = "volume"
        static let remainingVolumeKey   = "remaining_volume"
        static let executedVolumeKey    = "executed_volume"
        static let tradesCountKey       = "trades_count"
        
    }
    
    // MARK: Public Methods
    
    func update(orders: OrdersModel, with json: JSON) -> OrdersModel {
        if let bids = json[Constants.bidsKey] as? JSONArray {
            print(bids)
            var orders = [OrderModel]()
            
            for jsonOrder in bids {
                var order = OrderModel()
                if let id = jsonOrder[Constants.idKey] as? Int {
                    order.id = id
                }
                
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
        
        return orders
    }
    
    func createAndUpdateOrdersWith(json: JSON) -> OrdersModel {
        let orders = OrdersModel(buyOrders: BalancesModel(array: [BalanceModel]()),
                                 sellOrders: BalancesModel(array: [BalanceModel]()))
        _ = self.update(orders: orders, with: json)
        
        return orders
    }
}
