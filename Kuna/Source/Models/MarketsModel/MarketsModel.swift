//
//  MarketsModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 24/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RxSwift

class MarketsModel {
    
    // MARK: Initialization
    
    static let shared = MarketsModel()
    
    private init() {
        self.currentMarket = markets.first
    }

    // MARK: Public Properties
    
    let markets = MarketModel.performLoading()
    
    var currentMarket: MarketModel?
}
