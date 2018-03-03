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
        static let orderIdKeyString  = "id"
    }
    
    // MARK: Public Properties
    
    let orderId: Int64
    override var urlPath: String { return "api/v2/order/delete" }
    override var httpMethod: HTTPMethod { return .post }
    
    // MARK: Initialization
    
    init(token: AccessTokenModel, orderId: Int64) {
        self.orderId = orderId
        
        super.init(token: token)
    }
    
    // Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.orderIdKeyString] = String(self.orderId)

        super.updateParameters()
    }
    
}
