//
//  ActiveOrdersModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class ActiveOrdersModel {
    
    // MARK: Private Parameters
    
    var buyOrders: [ActiveOrderModel]
    var sellOrders: [ActiveOrderModel]
    
    // MARK: Initialization
    
    init(buyOrders: [ActiveOrderModel], sellOrders: [ActiveOrderModel]) {
        self.buyOrders = buyOrders
        self.sellOrders = sellOrders
    }
    
    convenience init(orders: [ActiveOrderModel]) {
        var buyOrders: [ActiveOrderModel] = []
        var sellOrders: [ActiveOrderModel] = []
        
        for order in orders {
            order.sideEnum == .buy ? buyOrders.append(order) : sellOrders.append(order)
        }
        
        self.init(buyOrders: buyOrders, sellOrders: sellOrders)
    }
}

