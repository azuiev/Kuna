//
//  PublicContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import Alamofire

class PublicContext: Context {

    // MARK: Public Properties

    var url:        String              = "https://kuna.io/"
    var parameters: [String : String]   = [:]
    var marketName: String              = ""
    
    var httpMethod: HTTPMethod  { return .get }
    var graphPath:  String      { return "" }
    var urlPath:    String      { return "" }
    var fullUrl:    String      { return self.url + self.urlPath }
    var tonce:      String      { return "" }
    
    // MARK: Public Methods
    
    func execute<T>(with resultType: T.Type, completionHandler: @escaping (Result<T>, String) -> ()) {
        self.updateParameters()
        
        Alamofire.request(self.fullUrl,
                          method: self.httpMethod,
                          parameters: self.parameters)
            .responseJSON() {
                switch $0.result {
                case .success(let value):
                    if let result = value as? T {
                        return self.parseSuccessResponse(response: result, with: completionHandler)
                    } else {
                        return self.parseFailedResponse(response: value, with: completionHandler)
                    }
                case .failure(let error):
                    completionHandler(Result.Failure(error), self.marketName)
                }
        }
    }
    
    func parseSuccessResponse<T>(response: T, with completionHandler: (Result<T>, String) -> ()) {
        completionHandler(Result.Success(response), self.marketName)
    }
    
    func parseFailedResponse<T>(response: Any, with completionHandler: (Result<T>, String) -> ()) {
        return completionHandler(Result.Failure(JSONError.parseError("Unable to convert \(response) to type \(T.self)")), self.marketName)
    }
    
    func updateParameters() {

    }
    
    
}
