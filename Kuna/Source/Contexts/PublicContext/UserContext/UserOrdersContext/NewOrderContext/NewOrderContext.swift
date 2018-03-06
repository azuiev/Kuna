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
        static let errorKey     = "error"
        static let messageKey   = "message"
        static let priceKey     = "price"
        static let volumeKey    = "volume"
        static let sideKey      = "side"
    }
    
    // MARK: Public Properties
    
    override var httpMethod: HTTPMethod { return .post }
    
    // MARK: Private Properties
    
    private let price: Double
    private let volume: Double
    private let side: String
    
    // MARK: Initialization
    
    init(user: CurrentUserModel, market: String, price: Double, volume: Double, side: String) {
        self.price = price
        self.volume = volume
        self.side = side
        
        super.init(user: user, market: market)
    }
    
    // Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.sideKey] = self.side
        self.parameters[Constants.volumeKey] = String(self.volume)
        self.parameters[Constants.priceKey] = String(self.price)
        
        super.updateParameters()
    }
    
    override func parseSuccessResponse<T>(response: T, with completionHandler: (Result<T>) -> ()) {
        if let json = response as? JSON {
            if let jsonError = json[Constants.errorKey] as? JSON {
                completionHandler(Result.Failure(JSONError.otherError(jsonError[Constants.messageKey] as? String ?? "")))
            } else {
                completionHandler(Result.Success(response))
            }
        } else {
            super.parseSuccessResponse(response: response, with: completionHandler)
        }
    }
}
