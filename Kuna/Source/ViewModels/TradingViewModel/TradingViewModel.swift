//
//  TradingViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 18/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class TradingViewModel {
    
    // MARK: Private Properties
    
    private let trading: CompletedOrderModel
    
    // MARK: Public Properties
    
    let priceFormatter = NumberFormatter()
    
    var price: String { return priceFormatter.string(from: NSNumber(value: self.trading.price)) ?? "" }
    var countMainCurrency: String { return String(format: "%.8f", self.trading.volumeMain) }
    var countSecondCurrency: String { return String(format: "%.8f", self.trading.volumeSecond) }
    
    // MARK: Initialization
    
    init(_ trading: CompletedOrderModel) {
        self.trading = trading
        
        self.priceFormatter.minimumFractionDigits = 0
        self.priceFormatter.maximumFractionDigits = 8
    }
}
