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
        static let marketValue      = "btcuah"
    }
    
    // MARK: Private Properties
    
    override var urlPath: String { return "api/v2/trades" }
    
    // MARK: Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.marketKeyString]  = Constants.marketValue
    }
}
