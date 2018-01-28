//
//  BalancesModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 28/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class BalancesModel {
    
    // MARK: Private Properties
    
    private var array: ArrayModel<BalanceModel>
    
    // MARK: Public Properties
    
    var balances: ArrayModel<BalanceModel> {
        return self.array
    }
    
    // MARK: Initialization
    
    init (balances: [BalanceModel]) {
        self.array = ArrayModel<BalanceModel>.init(array: balances)
    }
    
    init() {
        self.array = ArrayModel<BalanceModel>.init(array: [BalanceModel]())
    }
    
    //
}
