//
//  OrderCell.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet var priceLabel: UILabel?
    @IBOutlet var countMainCurrencyLabel: UILabel?
    @IBOutlet var countSecondCurrencyLabel: UILabel?
    
    // MARK Public Properties
    
    var order: ActiveOrderModel? {
        willSet {
            newValue.map { [weak self] in
                self?.fill(with: ActiveOrderViewModel($0))
            }
        }
    }
    
    func fill(with viewModel: ActiveOrderViewModel) {
        self.priceLabel?.text = viewModel.price
        self.countMainCurrencyLabel?.text = viewModel.volumeMainCurrency
        self.countSecondCurrencyLabel?.text = viewModel.volumeSecondCurrency
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.priceLabel?.text = nil
        self.countMainCurrencyLabel?.text = nil
        self.countSecondCurrencyLabel?.text = nil
    }
}
