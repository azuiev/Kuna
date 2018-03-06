//
//  JsonError.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 06/03/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case parseError(String)
    case otherError(String)
}

extension JSONError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .parseError(let description):
            return description
        case .otherError(let description):
            return description
        }
    }
}
