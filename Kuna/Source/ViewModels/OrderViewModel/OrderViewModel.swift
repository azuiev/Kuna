//
//  OrderViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class OrderViewModel {
    
    // MARK: Private Properties
    
    private let order: OrderModel
    
    // MARK: Public Properties
    
    var price: String { return String(self.order.price) }
    var countMainCurrency: String { return String(self.order.volume) }
    var countSecondCurrency: String { return String(self.order.price * self.order.volume) }
    // MARK: Initialization
    
    init(_ order: OrderModel) {
        self.order = order
    }
}
