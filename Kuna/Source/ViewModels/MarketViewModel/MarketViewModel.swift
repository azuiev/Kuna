//
//  MarketViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 22/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class MarketViewModel {
    
    // MARK: Private Properties
    
    private let market: MarketModel
    
    // MARK: Public Properties
    
    var marketName: String { return self.market.marketName }
    var mainCurrencyName: String {return self.market.mainCurrency?.name ?? ""}
    var secondCurrencyName: String {return self.market.secondaryCurrency?.name ?? "" }
    
    // MARK: Initialization
    
    init(_ market: MarketModel) {
        self.market = market
    }
}
