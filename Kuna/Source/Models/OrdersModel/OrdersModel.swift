//
//  OrdersModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class OrdersModel {
    
    // MARK: Private Parameters
    
    var buyOrders: [OrderModel]
    var sellOrders: [OrderModel]
    
    // MARK: Initialization
    
    init(buyOrders: [OrderModel], sellOrders: [OrderModel]) {
        self.buyOrders = buyOrders
        self.sellOrders = sellOrders
    }
    
    convenience init(orders: [OrderModel]) {
        var buyOrders: [OrderModel] = []
        var sellOrders: [OrderModel] = []
        
        for order in orders {
            order.side == .buy ? buyOrders.append(order) : sellOrders.append(order)
        }
        
        self.init(buyOrders: buyOrders, sellOrders: sellOrders)
    }
}

