//
//  CompletedOrderViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 18/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

class CompletedOrderViewModel: OrderViewModel<CompletedOrderModel> {
    
    // MARK: Public Properties
    
    var countSecondCurrency: String { return String(format: "%.8f", self.order.volumeSecond) }
}
