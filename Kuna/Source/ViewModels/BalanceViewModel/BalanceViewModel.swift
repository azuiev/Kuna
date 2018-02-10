//
//  BalanceViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 25/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class BalanceViewModel {
    
    // MARK: Private Properties
    
    private let balance: BalanceModel
    
    // MARK: Public Properties
    
    var code: String { return self.balance.currency.code }
    var name: String { return self.balance.currency.name }
    var count: String { return String(self.balance.count) }
    
    // MARK: Initialization
    
    init(_ balance: BalanceModel) {
        self.balance = balance
    }
}
