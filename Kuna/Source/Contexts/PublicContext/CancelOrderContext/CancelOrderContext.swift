//
//  CancelOrderContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 03/03/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import Alamofire

class CancelOrderContext: UserContext {

    // MARK: Constants
    
    private struct Constants {
        static let orderIdKey       = "id"
        static let urlPathString    = "api/v2/order/delete"
    }
    
    // MARK: Public Properties
    
    let orderId: Int64
    
    override var httpMethod:    HTTPMethod { return .post }
    override var urlPath:       String { return Constants.urlPathString }
    
    // MARK: Initialization
    
    init(token: AccessTokenModel, orderId: Int64) {
        self.orderId = orderId
        
        super.init(token: token)
    }
    
    // MARK: Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.orderIdKey] = String(self.orderId)

        super.updateParameters()
    }
}
