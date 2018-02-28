//
//  NewOrderViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 28/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class NewOrderViewModel: ControllerViewModel {

    var order: OrderModel?
    var completion: (OrderModel) -> ()?
    
    init(_ currentUserModel: CurrentUserModel, order: OrderModel? = nil, completion: @escaping (OrderModel) -> ()) {
        self.completion = completion
        self.order = order
        
        super.init(currentUserModel)
    }
}
