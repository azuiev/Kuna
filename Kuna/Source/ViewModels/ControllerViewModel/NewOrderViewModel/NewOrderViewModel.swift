//
//  NewOrderViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 28/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

class NewOrderViewModel: ControllerViewModel {

    // MARK: Public Properties
    
    let newOrderResult = PublishSubject<Result<JSON>>()
    var order: OrderModel?
    
    // MARK: Private Properties
    
    var completion: (OrderModel) -> ()?
    
    // MARK: Initialization
    
    init(_ currentUserModel: CurrentUserModel, order: OrderModel? = nil, completion: @escaping (OrderModel) -> ()) {
        self.completion = completion
        self.order = order
        
        super.init(currentUserModel)
    }
    
    // MARK: Public Methods
    
    func createOrder(side: OrderSide, volume: Double, price: Double) {
        guard let marketName = MarketsModel.shared.currentMarket?.marketName else { return }
        
        NewOrderContext(user: self.currentUser,
                        market: marketName,
                        price: price,
                        volume: volume,
                        side: side.rawValue)
            .execute(with: JSON.self) { [weak self] result, _ in
                self?.newOrderResult.onNext(result)
        }
    }
}
