//
//  Date+Extension.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 19/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension Date {
    
    var currentTimeInMiliseconds: Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded(.down))
    }
    
    var currentTimeInSeconds: Int {
        return Int((self.timeIntervalSince1970).rounded(.down))
    }
}
