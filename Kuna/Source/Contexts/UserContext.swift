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
        
        self.parameters = [Constants.accessKeyString : token.publicKey]
    }
    
    // MARK: Public Methods
    
    override func execute(with completionHandler: @escaping (Result<JSON>) -> ()) {
        self.parameters[Constants.tonceString] = String(Date().currentTimeInMiliseconds)
        self.parameters[Constants.signatureString] = self.evaluateSecret()
    }
    
    // MARK: Private methods
    
    private func evaluateSecret() -> String {
        //HEX(HMAC-SHA256("HTTP-verb|URI|params", secret_key))
        var stringForCoding = String(format: "%@|/%@|", self.httpMethod.rawValue, self.urlPath)
        self.parameters.forEach {
            stringForCoding.append(String(format:"%@=%@&", $0.key, $0.value))
        }
        
        stringForCoding = String(stringForCoding.dropLast())
        let binaryData = stringForCoding.hmac(algorithm: .SHA256, key: self.token.secretKey)
        
        return binaryData.toHexString()
    }
    
    private func save(response: JSON) {
        NSKeyedArchiver.archiveRootObject(response, toFile: self.fileName())
    }
    
    private func loadSavedResponse() -> [String : Any]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: self.fileName()) as? [String : Any]
    }
    
    private func fileName() -> String {
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
            return path.appending("/").appending(self.graphPath)
        } else {
            return ""
        }
    }
}

