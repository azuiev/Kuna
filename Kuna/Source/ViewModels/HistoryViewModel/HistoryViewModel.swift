//
//  HistoryViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 19/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import RxSwift

class HistoryViewModel: ViewModel {
    
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
    
    override func updateData() {
        guard let unwrappedMarket = self.market else { return }
        
        //TODO
        
        UserHistoryContext(token: self.currentUser.token, market: unwrappedMarket)
            .execute(with: JSONArray.self) { [weak self] in
                self?.ordersResult.onNext($0)
        }
    }
    
    func fill(with orders: [HistoryOrderModel]) {
        self.orders = orders
    }
}
