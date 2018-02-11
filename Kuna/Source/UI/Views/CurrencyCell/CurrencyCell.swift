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

    @IBOutlet var currencyNameLabel: UILabel?
    @IBOutlet var countLabel: UILabel?
    @IBOutlet var currencyImageView: UIImageView?
    
    // MARK Public Properties
    
    var balance: BalanceModel? {
        willSet {
            newValue.map { [weak self] in
                self?.fill(with: BalanceViewModel($0))
            }
        }
    }
    
    func fill(with viewModel: BalanceViewModel) {
        self.currencyNameLabel?.text = viewModel.name
        self.countLabel?.text = viewModel.count
        self.currencyImageView?.image = viewModel.image
    }
}
