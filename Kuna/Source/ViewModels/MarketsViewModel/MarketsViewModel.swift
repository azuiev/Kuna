//
//  MarketsViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 23/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class MarketsViewModel: ViewModel {
    
    // MARK: Public Properties
    
    var markets: [MarketModel]?
    
    // MARK: Initialization
    init(user: CurrentUserModel) {
        super.init(user)
    }
}
