//
//  GetContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit
import Alamofire

class GetContext: Context {
    
    // MARK: Constants
    
    private struct Constants {
        static let accessKeyString  = "access_key"
        static let tonceString      = "tonce"
        static let signatureString  = "signature"
    }
    
    // MARK: Public Properties
    
    var httpMethod: HTTPMethod { return .get }
    var graphPath: String { return "" }
    var parameters: [String : String]
    var tonce = { return 12345678 }
    var url = "https://kuna.io/"
    var urlPath: String { return "" }
    var fullUrl: String { return self.url + self.urlPath }
    
    // MARK: Private Properties
    
    private var token: AccessTokenModel
    
    // MARK: Initialization
    
    init(token: AccessTokenModel) {
        self.token = token
        self.parameters = [Constants.accessKeyString : token.publicKey]
        
        super.init()
    }
    
    // MARK: Public Methods
    
    func executeWithResponse() -> JSON? {
        self.parameters[Constants.tonceString] = String(Date().currentTimeInMiliseconds)
        self.parameters[Constants.signatureString] = self.evaluateSecret()
        
        return nil
    }
    
    // MARK: Private methods
    
    private func evaluateSecret() -> String {
        //HEX(HMAC-SHA256("HTTP-verb|URI|params", secret_key))
        var stringForCoding = String(format: "%@|/%@?", self.httpMethod.rawValue, self.urlPath)
        self.parameters.forEach {
            stringForCoding.append(String(format:"%@=%@&", $0.key, $0.value))
        }
        
        stringForCoding = String(stringForCoding.dropLast())
        let signature = stringForCoding.hmac(algorithm: .SHA256, key: self.token.secretKey)
        
        print(stringForCoding)
        print(self.token.secretKey)
        print(signature)
        
        
        return signature
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

