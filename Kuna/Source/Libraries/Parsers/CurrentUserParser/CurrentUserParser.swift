//
//  CurrentUserParser.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 28/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class CurrentUserParser {
    
    // MARK: Public Methods
    
    func update(user: CurrentUserModel, with json: JSON) -> CurrentUserModel {
        
        // TODO
        let activated:Bool = (json["activated"] != nil)
        let email:String = json["email"] as! String
        let balances: JSONArray = json["accounts"] as! JSONArray
        for item in balances {
            let currency = CurrencyModel.currencyWith(code: item["currency"] as! String)
            print(currency.name)
            let count = item["balance"]
            let lockedCount = item["locked"]
        }
        
        return user
    }
    
    func createAndUpdateUserWith(token: AccessTokenModel, json: JSON) -> CurrentUserModel{
        return self.update(user: CurrentUserModel(token), with: json)
    }
}
