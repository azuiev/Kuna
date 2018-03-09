//
//  LoginContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 17/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class LoginContext: UserContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let errorKey         = "error"
        static let messageKey       = "message"
        static let urlPathString    = "api/v2/members/me"
    }
    
    // MARK: Public Properties
    
    override var urlPath: String { return Constants.urlPathString }
    
    // MARK: Public Methods
    
    override func parseSuccessResponse<T>(response: T, with completionHandler: (Result<T>, String) -> ()) {
        if let json = response as? JSON {
            if let jsonError = json[Constants.errorKey] as? JSON {
                completionHandler(Result.Failure(JSONError.otherError(jsonError[Constants.messageKey] as? String ?? "")), self.marketName)
            } else {
                completionHandler(Result.Success(response), self.marketName)
            }
        } else {
            super.parseSuccessResponse(response: response, with: completionHandler)
        }
    }
}
