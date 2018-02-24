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
    
    var order: OrderModel? {
        willSet {
            newValue.map { [weak self] in
                self?.fill(with: OrderViewModel($0))
            }
        }
    }
    
    func fill(with viewModel: OrderViewModel) {
        self.priceLabel?.text = viewModel.price
        self.countMainCurrencyLabel?.text = viewModel.countMainCurrency
        self.countSecondCurrencyLabel?.text = viewModel.countSecondCurrency
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.priceLabel?.text = nil
        self.countMainCurrencyLabel?.text = nil
        self.countSecondCurrencyLabel?.text = nil
    }
}
