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
        static let marketKey        = "market"
        static let urlPathString    = "api/v2/trades"
    }
    
    // MARK: Private Properties
    
    let market: String
    
    override var urlPath: String { return Constants.urlPathString }

    // MARK: Initialization
    
    init( market: String) {
        self.market = market
    }
    
    // MARK: Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.marketKey]  = self.market
    }
}
