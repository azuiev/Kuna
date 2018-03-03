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
        static let accessKeyString  = "access_key"
        static let tonceString      = "tonce"
        static let signatureString  = "signature"
    }
    
    // MARK: Private Properties
    
    private var token: AccessTokenModel
    
    // MARK: Initialization
    
    init(token: AccessTokenModel) {
        self.token = token
        
        super.init()
    }
    
    // MARK: Public Methods
    
    override func updateParameters() {
        self.parameters[Constants.accessKeyString]  = self.token.publicKey
        self.parameters[Constants.tonceString]      = String(Date().currentTimeInMiliseconds)
        self.parameters[Constants.signatureString]  = self.evaluateSecret()
    }
    
    override func parseFailedResponse<T>(response: Any, with completionHandler: (Result<T>) -> ()) {
        if let json = response as? JSON {
            if let jsonError = json["error"] as? JSON {
                completionHandler(Result.Failure(JSONError.otherError(jsonError["message"] as? String ?? "")))
            }
        } else {
            super.parseFailedResponse(response: response, with: completionHandler)
        }
    }
    
    // MARK: Private methods
    
    private func evaluateSecret() -> String {
        //HEX(HMAC-SHA256("HTTP-verb|URI|params", secret_key))
        var stringForCoding = String(format: "%@|/%@|", self.httpMethod.rawValue, self.urlPath)
        let keys = self.parameters.keys.sorted()
        //let keys = self.parameters.keys
        
        for key in keys {
            stringForCoding.append(String(format:"%@=%@&", key, self.parameters[key] ?? ""))
        }
        
        stringForCoding = String(stringForCoding.dropLast())
        let binaryData = stringForCoding.hmac(algorithm: .SHA256, key: self.token.secretKey)
        
        return binaryData.toHexString()
    }
}

