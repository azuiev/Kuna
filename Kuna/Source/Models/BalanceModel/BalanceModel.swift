//
//  BalanceModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 25/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class BalanceModel {
    
    // MARK: Public Properties
    
    let currency: CurrencyModel
    var count: Double
    
    // MARK: Initialization
    
    init(currency: CurrencyModel, count: Double = 0.0) {
        self.currency = currency
        self.count = count
    }
}
