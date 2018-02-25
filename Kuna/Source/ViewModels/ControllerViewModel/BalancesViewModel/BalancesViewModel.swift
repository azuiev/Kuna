//
//  BalancesViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 24/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class BalancesViewModel: ControllerViewModel {
    
    // MARK: Public Properties
    
    var balances: BalancesModel
    
    // MARK: Initialization
    
    init(user: CurrentUserModel, balances: BalancesModel) {
        self.balances = balances
        
        super.init(user)
    }
}
