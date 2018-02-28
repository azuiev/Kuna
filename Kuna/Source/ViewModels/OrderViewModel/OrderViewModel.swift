//
//  OrderViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class OrderViewModel<T: OrderModel> {
    
    // MARK: Private Properties
    
    let order: T
    
    // MARK: Public Properties
    
    let priceFormatter = NumberFormatter()
    
    var price: String { return priceFormatter.string(from: NSNumber(value: self.order.price)) ?? "" }
    var volumeMainCurrency: String { return String(format: "%.8f", self.order.volumeMain) }
    var volumeSecondCurrency: String { return String(format: "%.8f", self.order.volumeMain * self.order.price) }
    
    // MARK: Initialization
    
    init(_ order: T) {
        self.order = order
        
        self.priceFormatter.minimumFractionDigits = 0
        self.priceFormatter.maximumFractionDigits = 8
    }
}
