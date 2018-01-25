//
//  CurrencyModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 24/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class CurrencyModel: Hashable {
    
    // MARK: Hashable
    
    var hashValue: Int { return self.name.hashValue }
    
    static func ==(lhs: CurrencyModel, rhs: CurrencyModel) -> Bool {
        return lhs.name == rhs.name
    }
    
    // MARK: Public property
    
    let code: String
    let name: String
    let digital: Bool
    let icon: ImageModel?

    init(code: String, name: String, digital: Bool = false, image: ImageModel? = nil) {
        self.code = code
        self.name = name
        self.digital = digital
        self.icon = image
    }
}
