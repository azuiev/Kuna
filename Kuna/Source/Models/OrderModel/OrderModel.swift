//
//  OrderModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

enum OrderSide: String {
    case buy
    case sell
}

enum OrderType: String {
    case limit
    case market
}

class OrderModel {
   
    // MARK: Public Properties
    
    var id: Int = 0
    var side: OrderSide? = .buy
    var type: OrderType? = .limit
    var price: Double = 0.0
    var averagePrice: Double = 0.0
    var state: String = "wait"
    var market: String = ""
    var createdTime: Date = Date()
    var volume: Double = 0.0
    var remainingVolume: Double = 0.0
    var executedVolume: Double = 0.0
    var tradesCount: Int = 0
    
    
}
