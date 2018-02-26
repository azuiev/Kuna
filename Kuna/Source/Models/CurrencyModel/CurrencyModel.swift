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
        
        var result: [CurrencyModel] = []
        
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? JSON {
                    if let currencies = jsonResult["currencies"] as? JSONArray {
                        for item in currencies {
                            if let code = item["code"] as? String, let name = item["name"] as? String {
                                result.append(CurrencyModel(code: code, name: name))
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
