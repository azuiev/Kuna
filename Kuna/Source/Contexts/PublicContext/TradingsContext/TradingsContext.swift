//
//  TradingsContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 18/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import Alamofire

class TradingsContext: PublicContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let marketKeyString  = "market"
    }
    
    // MARK: Private Properties
    
    override var urlPath: String { return "api/v2/trades" }
    let market: String
    
    // MARK: Initialization
    
    init( market: String) {
        self.market = market
    }
    
    // MARK: Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.marketKeyString]  = self.market
    }
}
