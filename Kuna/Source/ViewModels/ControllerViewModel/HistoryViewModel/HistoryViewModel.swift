//
//  HistoryViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 19/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import RxSwift

class HistoryViewModel: ControllerViewModel {
    
    // MARK: Public Properties
    
    let ordersResult = PublishSubject<Result<JSONArray>>()
    let ordersSubject = PublishSubject<ArrayModel<HistoryOrderModel>>()
    
    var orders = ArrayModel<HistoryOrderModel>() {
        didSet {
            self.ordersSubject.onNext(self.orders)
        }
    }

    // MARK: Public Methods

    override func clearTables() {
        self.orders = ArrayModel(array: [HistoryOrderModel]())
        
        super.clearTables()
    }
    
    override func executeContext(with marketName: String) {
        UserHistoryContext(user: self.currentUser, market: marketName)
            .execute(with: JSONArray.self) { [weak self] result, marketName in
                if marketName == self?.market?.marketName {
                    self?.ordersResult.onNext(result)
                }
        }
    }
    
    override func updateModelFromDbData(with marketName: String) {
        let dbOrders = RealmService.shared.getObjectsWith(type: HistoryOrderModel.self,
                                                          filter: self.configureFilter(marketName: marketName))
        
        if dbOrders.count > 0 {
            self.orders = ArrayModel(array: dbOrders)
        }
    }
    
    func fill(with orders: [HistoryOrderModel]) {
        self.orders = ArrayModel(array: orders)
        
        self.updateDbData(with: orders)
    }
}
