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
    
    var code: String { return self.order.market }
    var name: String { return String(self.order.price) }
    var count: String { return String(self.order.volume) }
    
    // MARK: Initialization
    
    init(_ order: OrderModel) {
        self.order = order
    }
}
