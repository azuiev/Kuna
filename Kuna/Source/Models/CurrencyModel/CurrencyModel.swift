//
//  CurrencyModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 24/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

// MARK: Protocols

extension Hashable where Self: CurrencyModel {
    var hashValue: Int { return self.name.hashValue }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
    }
}

class CurrencyModel: Hashable {
    
    // MARK: Class Methods {
    
    static func currencyWith(code: String) -> CurrencyModel {
        
        guard let result = CurrencyModel.currencies[code] else {
            let newCurrency = CurrencyModel(code: code, name: code)
            CurrencyModel.currencies[code] = newCurrency
            
            return newCurrency
        }
        
        return result
    }
    
    // Protocol Loadable
    
    static func load() {
        var currencies: [String : CurrencyModel] = [:]
    
        currencies["uah"] = CurrencyModel(code: "UAH", name: "Hryvnia", isCrypto: false)
        currencies["btc"] = CurrencyModel(code: "BTC", name: "Bitcoin")
        currencies["kun"] = CurrencyModel(code: "KUN", name: "KUN")
        currencies["gol"] = CurrencyModel(code: "GOL", name: "GOLOS")
        currencies["eth"] = CurrencyModel(code: "ETH", name: "Ethereum")
        currencies["waves"] = CurrencyModel(code: "WAVES", name: "Waves")
        currencies["bch"] = CurrencyModel(code: "BCH", name: "Bitcoin Cash")
        currencies["gbg"] = CurrencyModel(code: "GBG", name: "Golos Gold")
        currencies["rmc"] = CurrencyModel(code: "RMC", name: "Russian miner coin")
        currencies["r"] = CurrencyModel(code: "R", name: "Revain")
        currencies["arn"] = CurrencyModel(code: "ARN", name: "Aeron")
        currencies["evr"] = CurrencyModel(code: "EVR", name: "Everus")
        currencies["b2b"] = CurrencyModel(code: "B2B", name: "B2B")
        
        CurrencyModel.currencies = currencies
    }
    
    // MARK: Public property
    
    let code: String
    let name: String
    let crypto: Bool
    let icon: ImageModel?

    // MARK: Private Properties
    
    private static var currencies: [String : CurrencyModel] = [:]
    
    // MARK: Inititalization
    
    init(code: String, name: String, isCrypto: Bool = true, image: ImageModel? = nil) {
        self.code = code
        self.name = name
        self.crypto = isCrypto
        self.icon = image
    }
}
