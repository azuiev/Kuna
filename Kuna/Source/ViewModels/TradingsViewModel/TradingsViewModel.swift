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
    let buyOrdersSubject = PublishSubject<[OrderModel]>()
    let sellOrdersSubject = PublishSubject<[OrderModel]>()
    let tradingsSubject = PublishSubject<BalancesModel>()
    
    var buyOrders: [OrderModel] {
        didSet {
            self.buyOrdersSubject.onNext(self.buyOrders)
        }
    }
    
    var sellOrders: [OrderModel] {
        didSet {
            self.sellOrdersSubject.onNext(sellOrders)
        }
    }
    
    var tradings: BalancesModel {
        didSet {
            self.tradingsSubject.onNext(tradings)
        }
    }
    
    // MARK: Private Properties
    
    private var timer: Timer?
    
    // MARK: Initialization
    
    init(user: CurrentUserModel, balances: BalancesModel) {
        self.buyOrders = []
        self.sellOrders = []
        self.tradings = balances
        
        super.init(user)
    }
    
    // Public Methods
    
    func onSelectSegment(with table: TableType) {
        switch table {
        case .buyTable, .sellTable: self.startUpdating(with: 30) { _ in
            OrdersContext().execute { [weak self] in
                self?.ordersResult.onNext($0)
            }}
        case .tradingsTable:  self.startUpdating(with: 30) { _ in
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
