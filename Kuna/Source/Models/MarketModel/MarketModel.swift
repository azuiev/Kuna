//
//  MarketModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 11/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension MarketModel: Hashable {
    var hashValue: Int { return self.marketName.hashValue }
    
    static func ==(lhs: MarketModel, rhs: MarketModel) -> Bool {
        return lhs.marketName == rhs.marketName
    }
}

class MarketModel {
    
    // MARK: Public Properties
    
    var mainCurrency: CurrencyModel
    var secondaryCurrency: CurrencyModel

    var marketName: String {
        return String(format: "%@%@", self.mainCurrency.code, self.secondaryCurrency.code)
    }
    
    // MARK: Initialization
    
    init(mainCurrency: CurrencyModel, secondaryCurrency: CurrencyModel) {
        self.mainCurrency = mainCurrency
        self.secondaryCurrency = secondaryCurrency
    }
    
    convenience init (_ mainCurrencyCode: String, _ secondaryCurrencyCode: String) {
        self.init(mainCurrency: CurrencyModel.currencyWith(code: mainCurrencyCode),
                  secondaryCurrency: CurrencyModel.currencyWith(code: secondaryCurrencyCode))
    }
    
    static func performLoading() {
        
        let markets: ArrayModel<MarketModel> = ArrayModel<MarketModel>(array: [])
        
        //RealmService.shared.deleteAll()
        markets.add(object: MarketModel("btc", "uah"))
        markets.add(object: MarketModel("eth", "uah"))
        markets.add(object: MarketModel("waves", "uah"))
        markets.add(object: MarketModel("gbg", "uah"))
        markets.add(object: MarketModel("bch", "uah"))
        markets.add(object: MarketModel("kun", "btc"))
        markets.add(object: MarketModel("gol", "gbg"))
        markets.add(object: MarketModel("bch", "btc"))
        markets.add(object: MarketModel("rmc", "btc"))
        markets.add(object: MarketModel("r", "btc"))
        markets.add(object: MarketModel("arn", "btc"))
        markets.add(object: MarketModel("evr", "btc"))
        markets.add(object: MarketModel("b2b", "btc"))
        markets.add(object: MarketModel("xrp", "uah"))
        markets.add(object: MarketModel("eos", "btc"))
        markets.add(object: MarketModel("food", "btc"))
        markets.add(object: MarketModel("otx", "btc"))
        
        for index in 0...markets.count - 1 {
            markets[index].map {
                print($0.marketName)
            }
            //RealmService.shared.create(markets[index])
        }
        
        //let dbMarketModels = RealmService.shared.get(MarketModel.self)
    }
}
