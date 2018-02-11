//
//  MarketModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 11/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class MarketModel {
    
    // MARK: Public Properties
    
    let mainCurrency: CurrencyModel
    let secondaryCurrency: CurrencyModel

    var marketName: String { return String(format: "%s%s", self.mainCurrency.code, self.secondaryCurrency.code) }
    
    // MARK: Initialization
    
    init(mainCurrency: CurrencyModel, secondaryCurrency: CurrencyModel) {
        self.mainCurrency = mainCurrency
        self.secondaryCurrency = secondaryCurrency
    }
}
