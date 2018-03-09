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
        static let marketKey        = "market"
        static let urlPathString    = "api/v2/orders"
    }
    
    // MARK: Public Properties
    
    override var urlPath: String { return Constants.urlPathString }
    
    // MARK: Initialization
    
    init(user: CurrentUserModel, market: String) {
        super.init(user: user)
        
        self.marketName = market
    }
    
    // Public Methods
       
    override func updateParameters() {
        self.parameters[Constants.marketKey]  = self.marketName
        
        super.updateParameters()
    }
}
