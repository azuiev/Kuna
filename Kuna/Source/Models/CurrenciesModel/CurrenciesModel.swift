//
//  CurrenciesModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 14/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RealmSwift

class CurrencyiesModel {
    
    // MARK: Private Properties
    
    private var currencies: [String : CurrencyModel] = [:]
    
    // MARK: Initialization
    
    init(_ currencies: [CurrencyModel]) {
        for currency in currencies {
            self.currencies[currency.code] = currency
        }
    }
    
    // Public Methods
    
    func getCurrency(with code: String) -> CurrencyModel {
        if let result = self.currencies[code] {
            return result
        }
        
        let currency = CurrencyModel(code: code)
        currency.create()
        
        self.currencies[code] = currency
        
        return currency
    }
}
