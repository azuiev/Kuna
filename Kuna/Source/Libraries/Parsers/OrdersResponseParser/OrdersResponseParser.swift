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
            var array: [OrderModel] = []
            
            for jsonOrder in bids {
                array.append(self.order(with: jsonOrder))
            }
            
            orders.buyOrders = array
        }
        
        if let asks = json[Constants.asksKey] as? JSONArray {
            for jsonOrder in asks {
                orders.sellOrders.append(self.order(with: jsonOrder))
            }
        }
        
        return orders
    }
    
    func createAndUpdateOrdersWith(json: JSON) -> OrdersModel {
        let orders = OrdersModel(buyOrders: [OrderModel](),
                                 sellOrders: [OrderModel]())
        _ = self.update(orders: orders, with: json)
        
        return orders
    }
    
    // MARK: Private Methods
    
    private func order(with json: JSON) -> OrderModel {
        let order = OrderModel()
        
        if let id = json[Constants.idKey] as? Int { order.id = id }
        if let side = json[Constants.sideKey] as? String { order.side = OrderSide(rawValue: side) }
        if let type = json[Constants.typeKey] as? String { order.type = OrderType(rawValue: type) }
        if let state = json[Constants.stateKey] as? String { order.state = state }
        if let market = json[Constants.marketKey] as? String { order.market = market }
        if let date = json[Constants.dateKey] as? Date { order.createdTime = date }
        if let tradesCount = json[Constants.tradesCountKey] as? Int { order.tradesCount = tradesCount }
        if let volumeString = json[Constants.volumeKey] as? String {
            Double(volumeString).map {
                order.volume = $0
            }
        }
        
        if let priceString = json[Constants.priceKey] as? String {
            Double(priceString).map {
                order.price = $0
            }
        }
        
        if let averagePriceString = json[Constants.averagePriceKey] as? String {
            Double(averagePriceString).map {
                order.averagePrice = $0
            }
        }
        
        if let remainingVolumeString = json[Constants.remainingVolumeKey] as? String {
            Double(remainingVolumeString).map {
                order.remainingVolume = $0
            }
        }
        
        if let executedVolumeString = json[Constants.executedVolumeKey] as? String {
            Double(executedVolumeString).map {
                order.executedVolume = $0
            }
        }
        
        return order
    }
}
