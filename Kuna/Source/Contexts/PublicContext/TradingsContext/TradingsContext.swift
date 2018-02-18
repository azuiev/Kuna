//
//  TradingsContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 18/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import Alamofire

class TradingsContext: PublicContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let marketKeyString  = "market"
        static let marketValue      = "btcuah"
    }
    
    // MARK: Private Properties
    
    override var urlPath: String { return "api/v2/trades" }
    
    // MARK: Public Methods
    
    // MARK: Public Methods
    
    func execute(with completionHandler: @escaping (Result<JSONArray>) -> ()) {
        self.upfateParameters()
        
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
    override func upfateParameters() {
        self.parameters[Constants.marketKeyString]  = Constants.marketValue
    }
}
