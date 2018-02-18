//
//  TradingsResponseParser.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 10/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class TradingsResponseParser {
    
    // MARK: Constants
    
    private struct Constants {
        static let idKey                = "id"
        static let priceKey             = "price"
        static let volumeMainKey        = "volume"
        static let volumeSecondKey      = "funds"
        static let marketKey            = "market"
        static let dateKey              = "created_at"
    }
    
    // MARK: Public Methods
    
    func update(tradings: [TradingModel], with jsonArray: JSONArray) -> [TradingModel] {
        var mutableTradings = tradings
        for jsonTrading in jsonArray {
            mutableTradings.append(self.trading(with: jsonTrading))
        }
        
        return mutableTradings
    }
    
    func createAndUpdateTradingsWith(jsonArray: JSONArray) -> [TradingModel] {
        var tradings: [TradingModel] = []
        tradings = self.update(tradings: tradings, with: jsonArray)
        
        return tradings
    }
    
    // MARK: Private Methods
    
    private func trading(with json: JSON) -> TradingModel {
        let trading = TradingModel()
        
        if let id = json[Constants.idKey] as? Int { trading.id = id }
        if let market = json[Constants.marketKey] as? String { trading.market = market }
        if let date = json[Constants.dateKey] as? Date { trading.createdTime = date }
        if let priceString = json[Constants.priceKey] as? String {
            Double(priceString).map {
                trading.price = $0
            }
        }
        
        if let volumeMainString = json[Constants.volumeMainKey] as? String {
            Double(volumeMainString).map {
                trading.volumeMain = $0
            }
        }
        
        if let volumeSecondString = json[Constants.volumeMainKey] as? String {
            Double(volumeSecondString).map {
                trading.volumeSecond = $0
            }
        }
        
        return trading
    }
}
