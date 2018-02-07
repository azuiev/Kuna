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

extension Hashable where Self: CurrencyModel {
    var hashValue: Int { return self.name.hashValue }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
    }
}

@objcMembers class CurrencyModel: Object {
    
    // MARK: Class Methods {
    
    static func currencyWith(code: String) -> CurrencyModel {
        let lowercaseCode = code.lowercased()

        guard let result = CurrencyModel.currencies[lowercaseCode] else {
            let newCurrency = CurrencyModel(code: code.uppercased(), name: code)
            CurrencyModel.currencies[lowercaseCode] = newCurrency
            
            RealmService.shared.create(newCurrency)
            
            return newCurrency
        }
        
        return result
    }
    
    // MARK: Public property
    
    dynamic var code: String = ""
    dynamic var name: String = ""
    dynamic var crypto: Bool = true
    dynamic var icon: ImageModel? = nil
    
    // MARK: Private Properties
    
    private static var currencies: [String : CurrencyModel] = [:]
    
    // MARK: Inititalization
    
    convenience init(code: String, name: String, isCrypto: Bool = true, image: ImageModel? = nil) {
        self.init()
        
        self.code = code
        self.name = name
        self.crypto = isCrypto
        self.icon = image
    }
    
    // Protocol Loadable
    
    static func performLoading() {
        let dbCurrencies = RealmService.shared.get(CurrencyModel.self)
        var currencies: [String : CurrencyModel] = [:]
        
        /*
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
         */
        
        for item in dbCurrencies {
            currencies[item.code.lowercased()] = item
        }
        
        CurrencyModel.currencies = currencies
    }
    

}