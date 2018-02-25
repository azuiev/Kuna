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

extension CurrencyModel {
    static func performLoading() -> [CurrencyModel] {
        let currencies = [("UAH", "Hryvnia"),
                          ("BTC", "Bitcoin"),
                          ("KUN", "KUN"),
                          ("GOL", "GOLOS"),
                          ("ETH", "Ethereum"),
                          ("WAVES", "Waves"),
                          ("BCH", "Bitcoin Cash"),
                          ("GBG", "Golos Gold"),
                          ("RMC", "Russian miner coin"),
                          ("R", "Revain"),
                          ("ARN", "Aeron"),
                          ("EVR", "Everus"),
                          ("B2B", "B2B"),
                          ("XRP", "Ripple"),
                          ("EOS", "EOS"),
                          ("FOOD", "FoodCoin"),
                          ("OTX", "Octanox")]
        
        var result: [CurrencyModel] = []
        
        for (code, name) in currencies {
            result.append(CurrencyModel(code: code, name: name))
        }
        
        return result
    }
}

class CurrencyModel: Equatable {
    
    // MARK: Public property
    
    var code: String = ""
    var name: String = ""
    var image: String = "default"
    
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
