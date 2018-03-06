//
//  OrdersResponseParser.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class OrdersParser {
    
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
        static let volumeMainKey        = "volume"
        static let volumeSecondKey      = "funds"
        static let remainingVolumeKey   = "remaining_volume"
        static let executedVolumeKey    = "executed_volume"
        static let tradesCountKey       = "trades_count"
    }
    
    // MARK: Public Methods
    
    func update<T: OrderModel>(orders: [T], with type: T.Type, json: JSON) -> [T] {
        var mutableOrders = orders
        if let bids = json[Constants.bidsKey] as? JSONArray {
   
            for jsonOrder in bids {
                self.order(orderType: type, json: jsonOrder).map {
                    mutableOrders.append($0)
                }
            }
        }
        
        if let asks = json[Constants.asksKey] as? JSONArray {
            for jsonOrder in asks {
                self.order(orderType: type, json: jsonOrder).map {
                    mutableOrders.append($0)
                }
            }
        }
        
        return mutableOrders
    }
    
    func update<T: OrderModel>(orders: [T], with type: T.Type, jsonArray: JSONArray) -> [T] {
        var mutableOrders = orders
        
        for jsonOrder in jsonArray {
            self.order(orderType: type, json: jsonOrder).map {
                mutableOrders.append($0)
            }
        }
        
        return mutableOrders
    }
    
    func createAndUpdateOrdersWith<T: OrderModel>(type: T.Type, jsonArray: JSONArray) -> [T] {
        var orders: [T] = []
        orders = self.update(orders: orders, with: type, jsonArray: jsonArray)
        
        return orders
    }
    
    func createAndUpdateOrdersWith<T: OrderModel>(type: T.Type, json: JSON) -> [T] {
        var orders: [T] = []
        orders = self.update(orders: orders, with: type, json: json)
        
        return orders
    }
    
    func order<T: OrderModel>(orderType: T.Type, json: JSON) -> T? {
        let order: Any
        switch orderType {
        case is ActiveOrderModel.Type:
            order = self.activeOrderModel(with: json)
        case is HistoryOrderModel.Type:
            order = self.historyOrderModel(with: json)
        case is CompletedOrderModel.Type:
            order = self.completedOrderModel(with: json)
        default:
            let result = OrderModel()
            self.update(order: result, with: json)
            order = result
        }
        
        if let unwrappedOrder = order as? T {
            return unwrappedOrder
        }
        
        return nil
    }
    
    // MARK: Private Methods
    
    private func update(order: OrderModel, with json: JSON) {
        if let id = json[Constants.idKey] as? Int64 { order.id = id }
        if let market = json[Constants.marketKey] as? String { order.market = market }
        if let date = json[Constants.dateKey] as? Date { order.createdTime = date }
        if let volumeString = json[Constants.volumeMainKey] as? String {
            Double(volumeString).map {
                order.volumeMain = $0
            }
        }
        
        if let priceString = json[Constants.priceKey] as? String {
            Double(priceString).map {
                order.price = $0
            }
        }
    }
    
    private func activeOrderModel(with json: JSON) -> ActiveOrderModel {
        let order = ActiveOrderModel()
        
        self.update(order: order, with: json)
        
        if let side = json[Constants.sideKey] as? String { order.sideEnum = OrderSide(rawValue: side) }
        
        if let volumeString = json[Constants.volumeMainKey] as? String {
            Double(volumeString).map {
                order.volumeMain = $0
            }
        }
        
        if let priceString = json[Constants.priceKey] as? String {
            Double(priceString).map {
                order.price = $0
            }
        }
        
        return order
    }
    
    private func completedOrderModel(with json: JSON) -> CompletedOrderModel {
        let order = CompletedOrderModel()
        
        self.update(order: order, with: json)
        
        if let volumeSecondString = json[Constants.volumeMainKey] as? String {
            Double(volumeSecondString).map {
                order.volumeSecond = $0
            }
        }
        
        return order
    }
    
    private func historyOrderModel(with json: JSON) -> HistoryOrderModel {
        let order = HistoryOrderModel()
        
        self.update(order: order, with: json)
        
        if let side = json[Constants.sideKey] as? String { order.side = OrderSide(rawValue: side) }
        if let volumeSecondString = json[Constants.volumeSecondKey] as? String {
            Double(volumeSecondString).map {
                order.volumeSecond = $0
            }
        }
        
        return order
    }
}
