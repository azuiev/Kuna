//
//  PropertyService.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 06/03/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class PropertyService {
    
    // MARK: Initialization
    
    static let shared = PropertyService()
    
    private init() {}
    
    // MARK: Public Methods
    
    func getJsonFromPropertyFile(for key: String) -> JSONArray {
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? JSON {
                    if let result = jsonResult[key] as? JSONArray {
                        return result
                    }
                }
            } catch {
                print("Achtung!")
            }
        }
        
        return [JSON]()
    }
}
