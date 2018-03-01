//
//  NewOrderContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 01/03/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import Alamofire

class NewOrderContext: UserOrdersContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let priceKeyString  = "price"
        static let volumeKeyString  = "volume"
        static let sideKeyString  = "side"
    }
    
    // MARK: Public Properties
    
    override var httpMethod: HTTPMethod { return .post }
    
    // MARK: Private Properties
    
    private let price: Double
    private let volume: Double
    private let side: String
    
    // MARK: Initialization
    
    init(token: AccessTokenModel, market: String, price: Double, volume: Double, side: String) {
        self.price = price
        self.volume = volume
        self.side = side
        
        super.init(token: token, market: market)
    }
    
    // Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.sideKeyString] = self.side
        self.parameters[Constants.volumeKeyString] = String(self.volume)
        self.parameters[Constants.priceKeyString] = String(self.price)
        
        super.updateParameters()
    }
}
