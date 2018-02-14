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
        return lhs.code == rhs.code
    }
}

@objcMembers class CurrencyModel: DBModel {
    
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
    dynamic var image: String = "default"
    
    // MARK: Private Properties
    
    private static var currencies: [String : CurrencyModel] = [:]
    
    // MARK: Inititalization
    
    convenience init(code: String, name: String, isCrypto: Bool = true) {
        self.init()
        
        let lowercaseCode = code.lowercased()
        self.code = lowercaseCode
        self.name = name
        self.crypto = isCrypto
        self.image = lowercaseCode
    }
    
    convenience init(code: String) {
        self.init(code: code, name: code.uppercased())
    }
    
    static func prepareDefaultItems() {
        DBModel.deleteAll()
        
        CurrencyModel(code: "UAH", name: "Hryvnia", isCrypto: false).create()
        CurrencyModel(code: "BTC", name: "Bitcoin").create()
        CurrencyModel(code: "KUN", name: "KUN").create()
        CurrencyModel(code: "GOL", name: "GOLOS").create()
        CurrencyModel(code: "ETH", name: "Ethereum").create()
        CurrencyModel(code: "WAVES", name: "Waves").create()
        CurrencyModel(code: "BCH", name: "Bitcoin Cash").create()
        CurrencyModel(code: "GBG", name: "Golos Gold").create()
        CurrencyModel(code: "RMC", name: "Russian miner coin").create()
        CurrencyModel(code: "R", name: "Revain").create()
        CurrencyModel(code: "ARN", name: "Aeron").create()
        CurrencyModel(code: "EVR", name: "Everus").create()
        CurrencyModel(code: "B2B", name: "B2B").create()
        CurrencyModel(code: "XRP", name: "Ripple").create()
        CurrencyModel(code: "EOS", name: "EOS").create()
        CurrencyModel(code: "FOOD", name: "FoodCoin").create()
        CurrencyModel(code: "OTX", name: "Octanox").create()
    }
}
