//
//  NewOrderViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 28/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class NewOrderViewModel: ControllerViewModel {

    // MARK: Public Properties
    
    var order: OrderModel?
    
    // MARK: Private Properties
    
    private var completion: (OrderModel) -> ()?
    
    // MARK: Initialization
    
    init(_ currentUserModel: CurrentUserModel, order: OrderModel? = nil, completion: @escaping (OrderModel) -> ()) {
        self.completion = completion
        self.order = order
        
        super.init(currentUserModel)
    }
    
    // MARK: Public Methods
    
    func createOrder(side: OrderSide, volume: String, price: String) {
        let marketName = MarketsModel.shared.currentMarket?.marketName
        
        NewOrderContext(token: self.currentUser.token,
                        market: "wavesuah",
                        price: 200.00,
                        volume: 1.00,
                        side: "sell")
            .execute(with: JSON.self) {
                print($0)
        }
    }
}
