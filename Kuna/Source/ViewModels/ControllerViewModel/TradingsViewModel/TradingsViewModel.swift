//
//  TradingsViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class TradingsViewModel: ControllerViewModel {
    
    // MARK: Public Properties
    
    let tradingsResult = PublishSubject<Result<JSONArray>>()
    let ordersResult = PublishSubject<Result<JSON>>()
    let newOrderSubject = PublishSubject<Void>()
    let buyOrdersSubject = PublishSubject<ArrayModel<ActiveOrderModel>>()
    let sellOrdersSubject = PublishSubject<ArrayModel<ActiveOrderModel>>()
    let tradingsSubject = PublishSubject<ArrayModel<CompletedOrderModel>>()
    
    var selectedTable: TableType = .buyTable
    var lastSelectedOrder: OrderModel?
    
    var buyOrders: ArrayModel<ActiveOrderModel> {
        didSet {
            self.buyOrdersSubject.onNext(self.buyOrders)
        }
    }
    
    var sellOrders: ArrayModel<ActiveOrderModel> {
        didSet {
            self.sellOrdersSubject.onNext(self.sellOrders)
        }
    }
    
    var tradings: ArrayModel<CompletedOrderModel> {
        didSet {
            self.tradingsSubject.onNext(self.tradings)
        }
    }
    
    // MARK: Private Properties
    
    private var timer: Timer?
    
    // MARK: Initialization
    
    init(user: CurrentUserModel) {
        self.buyOrders = ArrayModel(array: [ActiveOrderModel]())
        self.sellOrders = ArrayModel(array: [ActiveOrderModel]())
        self.tradings = ArrayModel(array: [CompletedOrderModel]())
        
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
        self.buyOrders = ArrayModel(array: orders.buyOrders)
        self.sellOrders = ArrayModel(array: orders.sellOrders)
        
        self.updateSelectedOrder()
        let dbOrders = orders.buyOrders + orders.sellOrders
        if let marketName = self.market?.marketName {
            let userOrders = RealmService.shared.getObjectsWith(type: ActiveOrderModel.self,
                                                                filter: self.configureFilter(marketName: marketName, userOrder: true))
            var ids = [Int64]()
            _ = userOrders.map {
                ids.append($0.id)
            }

            _ = dbOrders.map {
                if ids.contains($0.id) {
                    $0.currentUserOrder = true
                }
            }
        }
        
        self.updateDbData(with: dbOrders, type: ActiveOrderModel.self)
    }
    
    func fillTradings(with tradings: [CompletedOrderModel]) {
        self.tradings = ArrayModel(array: tradings)
        
        self.updateSelectedOrder()
        self.updateDbData(with: tradings, type: CompletedOrderModel.self)

        for order in tradings {
            order.update()
        }
    }
    
    func disableUpdating() {
        self.timer?.invalidate()
    }
    
    override func executeContext(with marketName: String) {
       self.configureUpdating(with: marketName)
    }
    
    override func clearTables() {
        self.buyOrders = ArrayModel(array: [ActiveOrderModel]())
        self.sellOrders = ArrayModel(array: [ActiveOrderModel]())
        self.tradings =  ArrayModel(array: [CompletedOrderModel]())
        
        super.clearTables()
    }
    
    override func updateModelFromDbData(with marketName: String) {
        let dbActiveBuyOrders = RealmService.shared.getObjectsWith(type: ActiveOrderModel.self,
                                                                   filter: self.configureFilter(marketName: marketName, side: .buy))
        let dbActiveSellOrders = RealmService.shared.getObjectsWith(type: ActiveOrderModel.self,
                                                                    filter: self.configureFilter(marketName: marketName, side: .sell))
        let dbCompletedOrders = RealmService.shared.getObjectsWith(type: CompletedOrderModel.self,
                                                                   filter: self.configureFilter(marketName: marketName))
        if dbActiveBuyOrders.count > 0 {
            self.buyOrders = ArrayModel(array: dbActiveBuyOrders)
        }
        if dbActiveSellOrders.count > 0 {
            self.sellOrders = ArrayModel(array: dbActiveSellOrders)
        }
        if dbCompletedOrders.count > 0 {
            self.tradings = ArrayModel(array: dbCompletedOrders)
        }
        
        self.updateSelectedOrder()
    }
    
    func updateDbData<T: Object>(with array: [DBModel], type: T.Type) {
        if let marketName = self.market?.marketName {
            RealmService.shared.deleteObjectsWith(type: type, filter: self.configureFilter(marketName: marketName, userOrder: false))
        }
        
        for order in array {
            order.update()
        }
    }
    
    func updateSelectedOrder(with index: Int = 0) {
        switch self.selectedTable {
        case .buyTable:
            self.lastSelectedOrder = self.buyOrders[index]
        case .sellTable:
            self.lastSelectedOrder = self.sellOrders[index]
        case .tradingsTable:
            self.lastSelectedOrder = self.tradings[index]
        }
    }
    
    // MARK: Private Methods
    
    private func configureFilter(marketName: String, side: OrderSide) -> NSPredicate {
        return NSPredicate(format: "market = %@ AND side = %@", marketName, side.rawValue)
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
