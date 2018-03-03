//
//  OrderModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

enum OrderType: String {
    case limit
    case market
}

enum OrderSide: String {
    case buy
    case sell
}

class ActiveOrderModel: OrderModel {
   
    // MARK: Public Properties
    
    dynamic var type: OrderType? = .limit
    dynamic var averagePrice: Double = 0.0
    dynamic var state: String = "wait"
    dynamic var remainingVolume: Double = 0.0
    dynamic var executedVolume: Double = 0.0
    dynamic var tradesCount: Int = 0
    dynamic var side: String = OrderSide.buy.rawValue
    var sideEnum: OrderSide? {
        get {
            return OrderSide(rawValue: self.side) ?? .buy
        }
        set {
            self.side = newValue?.rawValue ?? "buy"
        }
    }
}
