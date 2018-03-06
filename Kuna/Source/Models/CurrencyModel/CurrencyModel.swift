//
//  CurrencyModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 24/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Protocols

extension Equatable where Self: CurrencyModel {
    var hashValue: Int { return self.name.hashValue }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.code == rhs.code
    }
}

extension CurrencyModel: JsonProperty {
    static func loadProperty() -> [CurrencyModel] {
        var result: [CurrencyModel] = []
        
        let currencies = PropertyService.shared.getJsonFromPropertyFile(for: Constants.propertyName)
        for item in currencies {
            if let code = item[Constants.codeKey] as? String, let name = item[Constants.nameKey] as? String {
                result.append(CurrencyModel(code: code, name: name))
            }
        }
        
        return result
    }
}

final class CurrencyModel: Equatable {
    
    // MARK: Constants
    
    private enum Constants {
        static let propertyName     = "currencies"
        static let codeKey          = "code"
        static let nameKey          = "name"
        static let defaultImageName = "default"
    }
    
    // MARK: Public property
    
    var code: String = ""
    var name: String = ""
    var image: String = Constants.defaultImageName
    
    // MARK: Inititalization
    
    init(code: String, name: String) {
        let lowercaseCode = code.lowercased()
        self.code = lowercaseCode
        self.name = name
        self.image = lowercaseCode
    }
    
    convenience init(code: String) {
        self.init(code: code, name: code.uppercased())
    }
}
