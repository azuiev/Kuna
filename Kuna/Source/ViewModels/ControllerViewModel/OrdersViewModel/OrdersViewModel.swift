//
//  OrdersViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 19/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import RxSwift

class OrdersViewModel: ControllerViewModel {
    
    // MARK: Public Properties
    
    let ordersResult = PublishSubject<Result<JSONArray>>()
    let ordersSubject = PublishSubject<[OrderModel]>()
    
    var orders: [ActiveOrderModel] {
        didSet {
            self.ordersSubject.onNext(self.orders)
        }
    }
    
    // MARK: Initialization
    
    init(user: CurrentUserModel, orders: [ActiveOrderModel]) {
        self.orders = orders
        
        super.init(user)
    }
    
    // MARK: Public Methods
    
    override func executeContext(with market: MarketModel) {
        UserOrdersContext(token: self.currentUser.token, market: market).execute(with: JSONArray.self) { [weak self] in
            self?.ordersResult.onNext($0)
        }
    }
    
    override func updateModelFromDbData(with market: MarketModel) {
        let dbOrders = RealmService.shared.getObjectsWith(type: ActiveOrderModel.self,
                                                          filter: self.configureFilter(with: market))
        
        if dbOrders.count > 0 {
            self.orders = dbOrders
        }
    }
    
    func fill(with orders: [ActiveOrderModel]) {
        self.orders = orders
        
        self.updateDbData(with: orders)
    }
}
