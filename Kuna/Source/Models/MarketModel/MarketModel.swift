//
//  MarketModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 11/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

// MARK: Protocol Hashable

extension Hashable where Self: MarketModel {
    var hashValue: Int { return self.marketName.hashValue }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.marketName == rhs.marketName
    }
}

// MARK: Protocol Loadable

extension MarketModel {
    static func performLoading() -> [MarketModel] {
        
        // MARK: Local functions
        
        func createMarket(_ mainCurrency: CurrencyModel?) -> ((CurrencyModel?) -> MarketModel?)? {
            if let unwrappedMainCurrency = mainCurrency {
                func createMarketNested(_ secondCurrency: CurrencyModel?) -> MarketModel? {
                    if let unwrappedSecondCurrency = secondCurrency {
                        return MarketModel(mainCurrency: unwrappedMainCurrency,
                                           secondaryCurrency: unwrappedSecondCurrency)
                    }
                    
                    return nil
                }
                
                return createMarketNested
            }
            
            return nil
        }
        
        let currenciesPair = [("btc", "uah"),
                       ("eth", "uah"),
                       ("waves", "uah"),
                       ("gbg", "uah"),
                       ("bch", "uah"),
                       ("kun", "btc"),
                       ("gol", "gbg"),
                       ("bch", "btc"),
                       ("rmc", "btc"),
                       ("r", "btc"),
                       ("arn", "btc"),
                       ("evr", "btc"),
                       ("b2b", "btc"),
                       ("xrp", "uah"),
                       ("eos", "btc"),
                       ("food", "btc"),
                       ("otx", "btc")]
        
        let currencies = CurrencyiesModel(DBModel.getObjectsWith(type: CurrencyModel.self))
        
        var result: [MarketModel] = []
        for(mainCurrencyCode, secondaryCurrencyCode) in currenciesPair {
            createMarket(currencies.getCurrency(with: mainCurrencyCode))?(currencies.getCurrency(with: secondaryCurrencyCode))
                .map {                    
                    result.append($0)
            }
        }
        
        return result
    }
}

class MarketModel {
    
    // MARK: Public Properties
    
    var mainCurrency: CurrencyModel
    var secondaryCurrency: CurrencyModel

    var marketName: String {
        return String(format: "%@%@", self.mainCurrency.code , self.secondaryCurrency.code)
    }
    
    // MARK: Initialization
    
    init(mainCurrency: CurrencyModel, secondaryCurrency: CurrencyModel) {
        self.mainCurrency = mainCurrency
        self.secondaryCurrency = secondaryCurrency
    }
    
    
    convenience init (_ mainCurrencyCode: String, _ secondaryCurrencyCode: String) {
        let currencies = CurrencyiesModel(DBModel.getObjectsWith(type: CurrencyModel.self))
        
        self.init(mainCurrency: currencies.getCurrency(with: mainCurrencyCode),
                  secondaryCurrency: currencies.getCurrency(with: secondaryCurrencyCode))
    }
 
}
