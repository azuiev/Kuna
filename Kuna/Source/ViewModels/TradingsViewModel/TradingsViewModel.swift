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
    let ordersResult = PublishSubject<Result<JSON>>()
    let buyOrdersVariable: Variable<BalancesModel>
    let sellOrdersVariable: Variable<BalancesModel>
    let tradingsVariable: Variable<BalancesModel>
    
    var buyOrders: BalancesModel
    var sellOrders: BalancesModel
    var tradings: BalancesModel
    
    // MARK: Private Properties
    
    private var timer: Timer?
    
    // MARK: Initialization
    
    init(user: CurrentUserModel, balances: BalancesModel) {
        self.buyOrders = balances
        self.sellOrders = balances
        self.tradings = balances
        
        self.buyOrdersVariable = Variable(self.buyOrders)
        self.sellOrdersVariable = Variable(self.sellOrders)
        self.tradingsVariable = Variable(self.tradings)
        
        super.init(user)
    }
    
    // Public Methods
    
    func onSelectSegment(with table: TableType) {
        switch table {
        case .buyTable, .sellTable: self.startUpdating(with: 10) { _ in
            OrdersContext().execute { [weak self] in
                self?.ordersResult.onNext($0)
            }}
        case .tradingsTable:  self.startUpdating(with: 10) { _ in
            OrdersContext().execute { [weak self] in
                self?.tradingsResult.onNext($0)
            }}
        }
    }
    
    func fillOrders(with orders: OrdersModel) {
        self.buyOrders = orders.buyOrders
        self.sellOrders = orders.sellOrders
    }
    
    func fillTradings(with tradings: BalancesModel) {
        self.tradings = tradings
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
