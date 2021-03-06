//
//  BalancesModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 28/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RxSwift

class BalancesModel: ArrayModel<BalanceModel> {
    
    // MARK: Subscript
    
    override subscript(index: Int) -> BalanceModel? {
        get {
            return self.object(at: index)
        }
        set {
            
        }
    }
}
