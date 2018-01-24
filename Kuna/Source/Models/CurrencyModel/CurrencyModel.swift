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
    
    let name: String
    let shortName: String
    let image: ImageModel? 
    
    init(name: String, shortName: String, image: ImageModel? = nil) {
        self.name = name
        self.shortName = shortName
        self.image = image
    }
}
