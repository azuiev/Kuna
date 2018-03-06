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

// MARK: Protocol JsonProperty

extension MarketModel: JsonProperty {
    static func createMarket(_ mainCurrency: CurrencyModel?) -> ((CurrencyModel?) -> MarketModel?)? {
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
    
    static func loadProperty() -> [MarketModel] {
        var result: [MarketModel] = []
        
        let markets = PropertyService.shared.getJsonFromPropertyFile(for: Constants.propertyName)
        let currencies = CurrencyiesModel.shared
        
        for market in markets {
            if let main = market[Constants.mainCurrencyKey] as? String,
                let second = market[Constants.secondCurrencyKey] as? String
            {
                createMarket(currencies.getCurrency(with: main))?(currencies.getCurrency(with: second))
                    .map {
                        result.append($0)
                }
            }
        }
        
        return result
    }
}

final class MarketModel {
    
    // MARK: Constants
    
    private enum Constants {
        static let propertyName         = "markets"
        static let mainCurrencyKey      = "main"
        static let secondCurrencyKey    = "second"
    }
    
    // MARK: Public Properties
    
    var mainCurrency:       CurrencyModel
    var secondaryCurrency:  CurrencyModel

    var marketName: String {
        return String(format: "%@%@", self.mainCurrency.code , self.secondaryCurrency.code)
    }
    
    // MARK: Initialization
    
    init(mainCurrency: CurrencyModel, secondaryCurrency: CurrencyModel) {
        self.mainCurrency = mainCurrency
        self.secondaryCurrency = secondaryCurrency
    }
    
    convenience init (_ mainCurrencyCode: String, _ secondaryCurrencyCode: String) {
        let currencies = CurrencyiesModel.shared
        
        self.init(mainCurrency: currencies.getCurrency(with: mainCurrencyCode),
                  secondaryCurrency: currencies.getCurrency(with: secondaryCurrencyCode))
    }
}
