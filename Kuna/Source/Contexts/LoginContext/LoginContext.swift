//
//  LoginContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire


enum JSONError: Error {
    case parseError
    case otherError
}


class LoginContext: GetContext {
    
    // MARK: Private Properties
    
    override var urlPath: String { return "api/v2/members/me" }
    
    // MARK: Public Methods
    
    override func execute(with completionHandler: @escaping (Result<JSON>) -> ()) {
        super.execute(with: completionHandler)
        
        Alamofire.request(self.fullUrl, method: self.httpMethod, parameters: parameters)
            .responseJSON {
                switch $0.result {
                case .success(let value):
                    let json = value as? JSON
                    if json?["error"] != nil {
                        completionHandler(Result.Failure(JSONError.otherError))
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
}
