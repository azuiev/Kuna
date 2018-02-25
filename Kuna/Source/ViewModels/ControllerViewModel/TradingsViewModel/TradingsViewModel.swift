//
//  TradingsViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

class TradingsViewModel: ControllerViewModel {
    
    // MARK: Public Properties
    
    let tradingsResult = PublishSubject<Result<JSONArray>>()
    let ordersResult = PublishSubject<Result<JSON>>()
    let newOrderSubject = PublishSubject<Void>()
    let buyOrdersSubject = PublishSubject<[OrderModel]>()
    let sellOrdersSubject = PublishSubject<[OrderModel]>()
    let tradingsSubject = PublishSubject<[CompletedOrderModel]>()
    
    var buyOrders: [ActiveOrderModel] {
        didSet {
            self.buyOrdersSubject.onNext(self.buyOrders)
        }
    }
    
    var sellOrders: [ActiveOrderModel] {
        didSet {
            self.sellOrdersSubject.onNext(self.sellOrders)
        }
    }
    
    var tradings: [CompletedOrderModel] {
        didSet {
            self.tradingsSubject.onNext(self.tradings)
        }
    }
    
    // MARK: Private Properties
    
    private var timer: Timer?
    
    // MARK: Initialization
    
    init(user: CurrentUserModel, balances: BalancesModel) {
        self.buyOrders = []
        self.sellOrders = []
        self.tradings = []
        
        super.init(user)
    }
    
    // Public Methods
    
    func onSelectSegment(with table: TableType) {
        guard let unwrappedMarket = self.market else { return }
        switch table {
        case .buyTable, .sellTable: self.startUpdating(with: 30) { _ in
            OrdersContext(market: unwrappedMarket).execute(with: JSON.self) { [weak self] in
                self?.ordersResult.onNext($0)
            }}
        case .tradingsTable: self.startUpdating(with: 30) { _ in
            TradingsContext(market: unwrappedMarket).execute(with: JSONArray.self) { [weak self] in
                self?.tradingsResult.onNext($0)
            }}
        }
    }
    
    func fillOrders(with orders: ActiveOrdersModel) {
        self.buyOrders = orders.buyOrders
        self.sellOrders = orders.sellOrders
        
        for order in orders.buyOrders {
            order.update()
        }
        
        for order in orders.sellOrders {
            order.update()
        }
    }
    
    func fillTradings(with tradings: [CompletedOrderModel]) {
        self.tradings = tradings
        
        for order in tradings {
            order.update()
        }
    }
    
    override func executeContext(with market: MarketModel) {
        OrdersContext(market: market).execute(with: JSON.self) { [weak self] in
            self?.ordersResult.onNext($0)
        }
    }
    
    override func updateModelFromDbData(with market: MarketModel) {
        let dbActiveBuyOrders = RealmService.shared.getObjectsWith(type: ActiveOrderModel.self,
                                                          filter: self.configureFilter(with: market))
        let dbActiveSellOrders = RealmService.shared.getObjectsWith(type: ActiveOrderModel.self,
                                                                   filter: self.configureFilter(with: market))
        let dbCompletedOrders = RealmService.shared.getObjectsWith(type: CompletedOrderModel.self,
                                                                    filter: self.configureFilter(with: market))
        if dbActiveBuyOrders.count > 0 {
            self.buyOrders = dbActiveBuyOrders
        }
        if dbActiveSellOrders.count > 0 {
            self.sellOrders = dbActiveSellOrders
        }
        if dbCompletedOrders.count > 0 {
            self.tradings = dbCompletedOrders
        }
    }
    
    // Private Methods
    
    private func startUpdating(with interval: Int, block: @escaping (Timer) -> ()) {
        self.disableUpdating()
        
        let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: block)
        timer.fire()
        
        self.timer = timer
    }
    
    func disableUpdating() {
        self.timer?.invalidate()
    }
}
