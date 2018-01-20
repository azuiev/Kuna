//
//  String+Extension.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 29/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension String {
    func hmac(algorithm: HMACAlgorithm, key: String) -> String {
        let cKey = key.cString(using: String.Encoding.utf8)
        let cData = self.cString(using: String.Encoding.utf8)
        var result = [CUnsignedChar](repeating: 0, count: Int(algorithm.digestLength()))
        CCHmac(algorithm.toCCHmacAlgorithm(), cKey!, Int(strlen(cKey!)), cData!, Int(strlen(cData!)), &result)
        let hmacData:NSData = NSData(bytes: result, length: (Int(algorithm.digestLength())))
        //let hmacBase64 = hmacData.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        //let resultNSString = NSString(data: hmacData as Data, encoding: String.Encoding.utf8.rawValue)!
        var resultString = ""
        for val in result {
            print("\(Character.init(val))")
        }
        
        return String(resultString)
    }
    
    func hex() -> String {
        let data = self.data(using: .utf8)!
        return data.map{ String(format:"%02x", $0) }.joined()
        /*return self.data(using: .utf8)
            .map {
                $0.map {
                    String(format:"%02x", $0)
                    }
                    .joined()
        } ?? ""*/
    }
    
    func asURL() -> URL? {
        _ = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .map { return URL(fileURLWithPath: $0) }
        return nil
    }
}
