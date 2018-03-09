//
//  OrdersContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class OrdersContext: PublicContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let marketKey        = "market"
        static let urlPathString    = "api/v2/order_book"
    }
    
    // MARK: Public Properties
    
    override var urlPath: String { return Constants.urlPathString }
    
    // MARK: Initialization
    
    init(market: String) {
        super.init()
        
        self.marketName = market
    }
    
    // MARK: Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.marketKey] = self.marketName
    }
}
