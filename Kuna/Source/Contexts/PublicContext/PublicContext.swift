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
            return "Unable to parse json: " + description
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
    
    func execute(with completionHandler: @escaping (Result<JSON>) -> ()) {
        self.updateParameters()
        
        Alamofire.request(self.fullUrl, method: self.httpMethod, parameters: parameters)
            .responseJSON {
                switch $0.result {
                case .success(let value):
                    let json = value as? JSON
                    if let jsonError = json?["error"] as? JSON {
                        
                        completionHandler(Result.Failure(JSONError.otherError(jsonError["message"] as? String ?? "")))
                    } else {
                        json.map {
                            completionHandler(Result.Success($0))
                        }
                    }
                case .failure(let error):
                    completionHandler(Result.Failure(error))
                }
        }
    }
    
    func updateParameters() {

    }
}
