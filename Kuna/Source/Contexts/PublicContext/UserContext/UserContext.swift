//
//  UserContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserContext: PublicContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let accessKey        = "access_key"
        static let signatureKey     = "signature"
        static let tonceKey         = "tonce"
        static let errorKey         = "error"
        static let messageKey       = "message"
        static let secretFormat     = "%@|/%@|"
        static let parametersFormat = "%@=%@&"
    }
    
    // MARK: Private Properties
    
    var token: AccessTokenModel {
        if let token = self.user.token {
            return token
        }
        
        return AccessTokenModel()
    }
    
    // MARK: Private Properties
    
    private var user: CurrentUserModel

    // MARK: Initialization
    
    init(user: CurrentUserModel) {
        self.user = user
        
        super.init()
    }
    
    // MARK: Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.accessKey]    = self.token.publicKey
        self.parameters[Constants.tonceKey]     = String(Date().currentTimeInMiliseconds)
        self.parameters[Constants.signatureKey] = self.evaluateSecret()
    }
    
    override func parseFailedResponse<T>(response: Any, with completionHandler: (Result<T>) -> ()) {
        if let json = response as? JSON {
            if let jsonError = json[Constants.errorKey] as? JSON {
                completionHandler(Result.Failure(JSONError.otherError(jsonError[Constants.messageKey] as? String ?? "")))
            }
        } else {
            super.parseFailedResponse(response: response, with: completionHandler)
        }
    }
    
    // MARK: Private Methods
    
    private func evaluateSecret() -> String {
        var stringForCoding = String(format: Constants.secretFormat, self.httpMethod.rawValue, self.urlPath)
        let keys = self.parameters.keys.sorted()
        
        for key in keys {
            stringForCoding.append(String(format:Constants.parametersFormat, key, self.parameters[key] ?? ""))
        }
        
        stringForCoding = String(stringForCoding.dropLast())
        let binaryData = stringForCoding.hmac(algorithm: .SHA256, key: self.token.secretKey)
        
        return binaryData.toHexString()
    }
}

