//
//  TradingModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 18/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class TradingModel {
    
    // MARK: Public Properties
    
    var id: Int = 0
    var price: Double = 0.0
    var volumeMain: Double = 0.0
    var volumeSecond: Double = 0.0
    var market: String = ""
    var createdTime: Date = Date()
}
