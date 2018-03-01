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
    
    var selectedTable: TableType = .buyTable
    var lastSelectedOrder: OrderModel?
    
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
        let oldValue = self.selectedTable
        self.selectedTable = table
        
        self.updateSelectedOrder()
        
        if (oldValue == .buyTable && table == .sellTable)
            || (oldValue == .sellTable && table == .buyTable)
        {
            return
        }
        
        self.configureUpdating(with: unwrappedMarket.marketName)
    }
    
    func fillOrders(with orders: ActiveOrdersModel) {
        self.buyOrders = orders.buyOrders
        self.sellOrders = orders.sellOrders
        
        self.updateSelectedOrder()
        
        RealmService.shared.deleteObjectsWith(type: ActiveOrderModel.self)
        
        for order in orders.buyOrders {
            order.update()
        }
        
        for order in orders.sellOrders {
            order.update()
        }
    }
    
    func fillTradings(with tradings: [CompletedOrderModel]) {
        self.tradings = tradings
        
        self.updateSelectedOrder()
        
        RealmService.shared.deleteObjectsWith(type: CompletedOrderModel.self)
        for order in tradings {
            order.update()
        }
    }
    
    override func executeContext(with marketName: String) {
       self.configureUpdating(with: marketName)
    }
    
    override func updateModelFromDbData(with marketName: String) {
        let dbActiveBuyOrders = RealmService.shared.getObjectsWith(type: ActiveOrderModel.self,
                                                                   filter: self.configureFilter(with: marketName, side: .buy))
        let dbActiveSellOrders = RealmService.shared.getObjectsWith(type: ActiveOrderModel.self,
                                                                    filter: self.configureFilter(with: marketName, side: .sell))
        let dbCompletedOrders = RealmService.shared.getObjectsWith(type: CompletedOrderModel.self,
                                                                    filter: self.configureFilter(with: marketName))
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
    
    func disableUpdating() {
        self.timer?.invalidate()
    }
    
    // MARK: Private Methods
    private func configureFilter(with marketName: String, side: OrderSide) -> NSPredicate {
        return NSPredicate(format: "market = %@ AND side = %@", marketName, side.rawValue)
    }
    
    private func updateSelectedOrder() {
        switch self.selectedTable {
        case .buyTable:
            self.lastSelectedOrder = self.buyOrders.first
        case .sellTable:
            self.lastSelectedOrder = self.sellOrders.first
        case .tradingsTable:
            self.lastSelectedOrder = self.tradings.first
        }
    }
    
    private func configureUpdating(with marketName: String) {
        switch self.selectedTable {
        case .buyTable, .sellTable: self.startUpdating(with: 30) { _ in
            OrdersContext(market: marketName).execute(with: JSON.self) { [weak self] in
                self?.ordersResult.onNext($0)
            }}
        case .tradingsTable: self.startUpdating(with: 30) { _ in
            TradingsContext(market: marketName).execute(with: JSONArray.self) { [weak self] in
                self?.tradingsResult.onNext($0)
            }}
        }
    }
    
    private func startUpdating(with interval: Int, block: @escaping (Timer) -> ()) {
        self.disableUpdating()
        
        let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: block)
        timer.fire()
        
        self.timer = timer
    }
}
