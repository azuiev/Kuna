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
    
    var side: OrderSide? = .buy
    var type: OrderType? = .limit
    var averagePrice: Double = 0.0
    var state: String = "wait"
    var remainingVolume: Double = 0.0
    var executedVolume: Double = 0.0
    var tradesCount: Int = 0
}
