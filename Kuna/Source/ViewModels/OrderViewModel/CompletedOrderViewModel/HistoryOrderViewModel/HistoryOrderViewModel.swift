//
//  HistoryOrderViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 18/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class HistoryOrderViewModel: OrderViewModel<HistoryOrderModel> {
    
    // MARK: Public Properties

    var sideImage: UIImage? {
        if let unwrappedSideName = self.order.side?.rawValue {
            return UIImage(named: unwrappedSideName)
        }
        
        return nil
    }
    
    var countSecondCurrency: String { return String(format: "%.8f", self.order.volumeSecond) }
}
