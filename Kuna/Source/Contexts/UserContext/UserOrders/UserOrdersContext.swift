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
        static let marketValue      = "wavesuah"
    }
    
    // MARK: Public Properties
    
    override var urlPath: String { return "api/v2/orders" }
    
    // Public Methods
    
    func execute(with completionHandler: @escaping (Result<JSONArray>) -> ()) {
        self.updateParameters()
        
        Alamofire.request(self.fullUrl, method: self.httpMethod, parameters: parameters)
            .responseJSON {
                switch $0.result {
                case .success(let value):
                    if let json = value as? JSONArray {
                        completionHandler(Result.Success(json))
                    } else {
                        completionHandler(Result.Failure(JSONError.parseError("Cant convert to JSONArray")))
                    }
                case .failure(let error):
                    completionHandler(Result.Failure(error))
                }
        }
    }
    
    override func updateParameters() {
        self.parameters[Constants.marketKeyString]  = Constants.marketValue
        
        super.updateParameters()
    }
}
