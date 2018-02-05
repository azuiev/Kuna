//
//  TradingsViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

class TradingsViewModel: ViewModel {
    
    // MARK: Public Properties
    
    let tradingsResult = PublishSubject<Result<JSON>>()
    var buyOrders: BalancesModel
    var sellOrders: BalancesModel
    
    // MARK: Initialization
    
    init(user: CurrentUserModel, balances: BalancesModel) {
        self.buyOrders = balances
        self.sellOrders = balances
        
        super.init(user)
    }
    
    // MARK: UI Actions
    
    func onUpdate(with event: Event<Int>) {
        TradingsContext().execute { [weak self] in
            self?.tradingsResult.onNext($0)
        }
    }
}
