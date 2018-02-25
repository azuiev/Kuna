//
//  BalanceModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 25/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

// MARK: Protocol Equtable

extension Equatable where Self: BalanceModel {
    var hashValue: Int { return self.currency.hashValue % self.count.hashValue }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.currency == rhs.currency && lhs.count == rhs.count
    }
}

class BalanceModel: Equatable {
    
    // MARK: Public Properties
    
    let currency: CurrencyModel
    var count: Double
    var locked: Double
    
    // MARK: Initialization
    
    init(currency: CurrencyModel, count: Double = 0.0, locked: Double = 0.0) {
        self.currency = currency
        self.count = count
        self.locked = locked
    }
}
