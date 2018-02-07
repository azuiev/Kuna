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
    
    // MARK: Private Properties
    
    var timer: Timer?

    
    // MARK: Initialization
    
    init(user: CurrentUserModel, balances: BalancesModel) {
        self.buyOrders = balances
        self.sellOrders = balances
        
        super.init(user)
    }
    
    // Public Methods
    
    func onSelectSegment(with table: TableType) {
        switch table {
        case .buyTable, .sellTable: self.startUpdating(with: 10) { _ in
            OrdersContext().execute { [weak self] in
                self?.tradingsResult.onNext($0)
            }}
        case .tradingsTable:  self.startUpdating(with: 10) { _ in
            OrdersContext().execute { [weak self] in
                self?.tradingsResult.onNext($0)
            }}
        }
    }
    
    // Private Methods
    
    private func startUpdating(with interval: Int, block: @escaping (Timer) -> ()) {
        self.disableUpdating()
        
        let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: block)
        timer.fire()
        
        self.timer = timer
    }
    
    private func disableUpdating() {
        self.timer?.invalidate()
    }
}
