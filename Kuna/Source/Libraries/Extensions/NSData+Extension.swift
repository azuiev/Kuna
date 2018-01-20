//
//  NSData+Extension.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 20/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension NSData {
    func toHexString() -> String {
        
        var result = ""
        var byte: UInt8 = 0
        
        for i in 0 ..< length {
            getBytes(&byte, range: NSMakeRange(i, 1))
            result = result.appending(String(format:"%02x", byte))
        }
        
        return result 
    }
}
