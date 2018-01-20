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
        
        return hmacData.toHexString()
    }
    
    func asURL() -> URL? {
        _ = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .map { return URL(fileURLWithPath: $0) }
        return nil
    }
}
