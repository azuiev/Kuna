//
//  CurrencyCell.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 24/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    // MARK: IBOutlets

    @IBOutlet var currencyName: UILabel?
    @IBOutlet var count: UILabel?
    
    // MARK Public Properties
    
    var currency: (currency:CurrencyModel, count: Double)? {
        willSet {
            if let user = newValue {
                self.fill(with: user)
            }
        }
    }
    
    func fill(with model: (currency:CurrencyModel, count: Double)) {
        self.currencyName?.text = model.currency.name
        self.count?.text = String(model.count)
    }
}
