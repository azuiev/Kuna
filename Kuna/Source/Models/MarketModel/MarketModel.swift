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

extension MarketModel: Loadable {
    static func performLoading() {
        
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
        
        DBModel.deleteObjectsWith(type: self)
        
        let markets = [("btc", "uah"),
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
        for(mainCurrencyCode, secondaryCurrencyCode) in markets {
            createMarket(currencies.getCurrency(with: mainCurrencyCode))?(currencies.getCurrency(with: secondaryCurrencyCode))
                .map {
                    $0.create()
            }
        }
    }
}

@objcMembers class MarketModel: DBModel {
    
    // MARK: Public Properties
    
    dynamic var mainCurrency: CurrencyModel? = nil
    dynamic var secondaryCurrency: CurrencyModel? = nil

    var marketName: String {
        return String(format: "%@%@", self.mainCurrency?.code ?? "", self.secondaryCurrency?.code ?? "")
    }
    
    // MARK: Initialization
    
    convenience init(mainCurrency: CurrencyModel, secondaryCurrency: CurrencyModel) {
        self.init()
        
        self.mainCurrency = mainCurrency
        self.secondaryCurrency = secondaryCurrency
    }
    
    
    convenience init (_ mainCurrencyCode: String, _ secondaryCurrencyCode: String) {
        let currencies = CurrencyiesModel(DBModel.getObjectsWith(type: CurrencyModel.self))
        
        self.init(mainCurrency: currencies.getCurrency(with: mainCurrencyCode),
                  secondaryCurrency: currencies.getCurrency(with: secondaryCurrencyCode))
    }
 
}
