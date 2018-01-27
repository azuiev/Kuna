//
//  BalancesViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 24/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class BalancesViewModel {
    
    // MARK: Public properties
    
    var balances: ArrayModel<BalanceModel>?
    
    init(json: JSON) {
        let test = parse(json)
    }
    
    // MARK: Private Methods
    
    private func parse(_ json: JSON) -> [BalanceModel] {
        for item in json {
            print(item)
        }
        
        return [BalanceModel]()
    }
}
