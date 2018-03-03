//
//  ActiveOrderViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 25/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ActiveOrderViewModel: OrderViewModel<ActiveOrderModel> {
    
    // MARK: Public Properties
    
    var countSecondCurrency: String { return String(format: "%.8f", self.order.price * self.order.volumeMain) }
    var orderSideImage: UIImage? {
        guard let unwrappedSide = self.order.sideEnum else { return nil }
        switch unwrappedSide {
        case .buy:
            return UIImage(named: "btc")
        case .sell:
            return UIImage(named: "uah")
        }
    }
}
