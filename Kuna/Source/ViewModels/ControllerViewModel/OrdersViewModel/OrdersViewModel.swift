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
    
    let cancelOrderResult = PublishSubject<Result<JSON>>()
    let cancelOrdersSubject = PublishSubject<Void>()
    let ordersResult = PublishSubject<Result<JSONArray>>()
    let ordersSubject = PublishSubject<Void>()
    
    var orders = ArrayModel<ActiveOrderModel>() {
        didSet {
            self.ordersSubject.onNext(())
        }
    }
    
    // MARK: Public Methods
    
    func cancelOrder(with index: Int) {
        let order = self.orders[index]
        order.map { [weak self] in
            if let user = self?.currentUser {
                CancelOrderContext(user: user, orderId: $0.id).execute(with: JSON.self) { [weak self] response, _ in
                    self?.cancelOrderResult.onNext(response)
                }
            }
        }
    }
    
    func delete(order: ActiveOrderModel) {
        let deleteOrder = RealmService.shared.realm.object(ofType: ActiveOrderModel.self, forPrimaryKey: order.id)
        
        deleteOrder.map { [weak self] in
            self?.orders.remove(object: $0)
            $0.delete()
            self?.cancelOrdersSubject.onNext(())
        }
    }
    
    override func clearTables() {
        self.orders = ArrayModel(array: [ActiveOrderModel]())
        
        super.clearTables()
    }
    
    override func executeContext(with marketName: String) {
        UserOrdersContext(user: self.currentUser, market: marketName)
            .execute(with: JSONArray.self) { [weak self] result, marketName in
            if marketName == self?.market?.marketName {
                self?.ordersResult.onNext(result)
            }
        }
    }


    override func updateModelFromDbData(with marketName: String) {
        let dbUserOrders = RealmService.shared.getObjectsWith(type: ActiveOrderModel.self,
                                                           filter: self.configureFilter(marketName: marketName, userOrder: true))
        
        if dbUserOrders.count > 0 {
            self.orders = ArrayModel(array: dbUserOrders)
        }
    }
    
    func fill(with orders: [ActiveOrderModel]) {
        self.orders = ArrayModel(array: orders)
        _ = orders.map {
            $0.currentUserOrder = true
        }
        
        self.updateDbData(with: orders)
    }
}
