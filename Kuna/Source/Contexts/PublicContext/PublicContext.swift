//
//  PublicContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import Alamofire

enum JSONError: Error {
    case parseError(String)
    case otherError(String)
}

extension JSONError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .parseError(let description):
            return description
        case .otherError(let description):
            return description
        }
    }
}

class PublicContext: Context {

    // MARK: Public Properties
    
    var httpMethod: HTTPMethod { return .get }
    var graphPath: String { return "" }
    var parameters: [String : String] = [:]
    var tonce = { return 12345678 }
    var url = "https://kuna.io/"
    var urlPath: String { return "" }
    var fullUrl: String { return self.url + self.urlPath }
    
    // MARK: Public Methods
    
    func execute<T>(with resultType: T.Type, completionHandler: @escaping (Result<T>) -> ()) {
        self.updateParameters()
        
        DispatchQueue.global(qos: .background).async {
            
        sleep(2)
        
        Alamofire.request(self.fullUrl,
                          method: self.httpMethod,
                          parameters: self.parameters)
            .responseJSON(queue: DispatchQueue.main) {
                
                switch $0.result {
                case .success(let value):
                    if let result = value as? T {
                        return self.parseSuccessResponse(response: result, with: completionHandler)
                    } else {
                        return self.parseFailedResponse(response: value, with: completionHandler)
                    }
                case .failure(let error):
                    completionHandler(Result.Failure(error))
                }
        }
    }
    }
    
    func parseSuccessResponse<T>(response: T, with completionHandler: (Result<T>) -> ()) {
        completionHandler(Result.Success(response))
    }
    
    func parseFailedResponse<T>(response: Any, with completionHandler: (Result<T>) -> ()) {
        return completionHandler(Result.Failure(JSONError.parseError("Unable to convert \(response) to type \(T.self)")))
    }
    
    func updateParameters() {

    }
}
