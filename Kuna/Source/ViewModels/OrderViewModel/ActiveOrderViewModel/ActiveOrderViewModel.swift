//
//  ActiveOrderViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 25/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ActiveOrderViewModel: OrderViewModel<ActiveOrderModel> {

    var countSecondCurrency: String { return String(format: "%.8f", self.order.price * self.order.volumeMain) }
}
