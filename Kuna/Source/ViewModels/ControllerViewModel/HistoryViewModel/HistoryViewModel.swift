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
    let ordersSubject = PublishSubject<[HistoryOrderModel]>()
    
    var orders: [HistoryOrderModel] {
        didSet {
            self.ordersSubject.onNext(self.orders)
        }
    }

    // MARK: Initialization
    
    init(user: CurrentUserModel, orders: [HistoryOrderModel]) {
        self.orders = orders
        
        super.init(user)
    }
    
    // MARK: Public Methods
    
    override func executeContext(with marketName: String) {
        UserHistoryContext(token: self.currentUser.token, market: marketName)
            .execute(with: JSONArray.self) { [weak self] in
                self?.ordersResult.onNext($0)
        }
    }
    
    override func updateModelFromDbData(with marketName: String) {
        let dbOrders = RealmService.shared.getObjectsWith(type: HistoryOrderModel.self,
                                                          filter: self.configureFilter(with: marketName))
        
        if dbOrders.count > 0 {
            self.orders = dbOrders
        }
    }
    
    func fill(with orders: [HistoryOrderModel]) {
        self.orders = orders
        
        self.updateDbData(with: orders)
    }
}
