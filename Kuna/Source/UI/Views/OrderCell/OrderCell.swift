//
//  OrderCell.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 03/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    // MARK: IBOutlets

    @IBOutlet var currencyName: UILabel?
    @IBOutlet var count: UILabel?
    
    // MARK Public Properties
    
    var balance: BalanceModel? {
        willSet {
            newValue.map { [weak self] in
                self?.fill(with: BalanceViewModel(balance: $0))
            }
        }
    }
    
    func fill(with viewModel: BalanceViewModel) {
        self.currencyName?.text = viewModel.code
        self.count?.text = viewModel.count
    }
}
