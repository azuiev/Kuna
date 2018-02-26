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
        
        let currencies = CurrencyiesModel.shared
        
        var result: [MarketModel] = []
            
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? JSON {
                    if let markets = jsonResult["markets"] as? JSONArray {
                        for market in markets {
                            if let main = market["main"] as? String, let second = market["second"] as? String {
                                createMarket(currencies.getCurrency(with: main))?(currencies.getCurrency(with: second))
                                    .map {
                                        result.append($0)
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Achtung!")
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
        let currencies = CurrencyiesModel.shared
        
        self.init(mainCurrency: currencies.getCurrency(with: mainCurrencyCode),
                  secondaryCurrency: currencies.getCurrency(with: secondaryCurrencyCode))
    }
 
}
