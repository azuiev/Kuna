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
        static let marketKeyString  = "market"
        static let marketValue      = "btcuah"
    }
    
    // MARK: Private Properties
    
    override var urlPath: String { return "api/v2/order_book" }
    
    // MARK: Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.marketKeyString] = Constants.marketValue
    }
}
