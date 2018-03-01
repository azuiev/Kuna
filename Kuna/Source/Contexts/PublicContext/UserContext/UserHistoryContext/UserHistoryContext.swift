//
//  UserHistoryContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 20/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class UserHistoryContext: UserContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let marketKeyString  = "market"
    }
    
    // MARK: Public Properties
    
    override var urlPath: String { return "api/v2/trades/my" }
    let market: String
    
    // MARK: Initialization
    
    init(token: AccessTokenModel, market: String) {
        self.market = market
        
        super.init(token: token)
    }
    
    // Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.marketKeyString]  = self.market
        
        super.updateParameters()
    }
}
