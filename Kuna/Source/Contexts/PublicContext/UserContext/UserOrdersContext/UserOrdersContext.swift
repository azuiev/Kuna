//
//  UserOrdersContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 19/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class UserOrdersContext: UserContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let marketKeyString  = "market"
    }
    
    // MARK: Public Properties
    
    let market: MarketModel
    
    override var urlPath: String { return "api/v2/orders" }
    
    // MARK: Initialization
    
    init(token: AccessTokenModel, market: MarketModel) {
        self.market = market
        
        super.init(token: token)
    }
    
    // Public Methods
       
    override func updateParameters() {
        self.parameters[Constants.marketKeyString]  = self.market.marketName
        
        super.updateParameters()
    }
}
