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
    
    // MARK: Private Properties
    
    override var urlPath: String { return "api/v2/members/me" }
    
    // MARK: Public Methods
    
    override func parseSuccessResponse<T>(response: T, with completionHandler: (Result<T>) -> ()) {
        if let json = response as? JSON {
            if let jsonError = json["error"] as? JSON {
                completionHandler(Result.Failure(JSONError.otherError(jsonError["message"] as? String ?? "")))
            } else {
                completionHandler(Result.Success(response))
            }
        } else {
            super.parseSuccessResponse(response: response, with: completionHandler)
        }
    }
}
