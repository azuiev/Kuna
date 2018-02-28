//
//  CompletedOrderCell.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 24/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class CompletedOrderCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet var priceLabel: UILabel?
    @IBOutlet var countMainCurrencyLabel: UILabel?
    @IBOutlet var countSecondCurrencyLabel: UILabel?
    
    // MARK Public Properties
    
    var order: CompletedOrderModel? {
        willSet {
            newValue.map { [weak self] in
                self?.fill(with: CompletedOrderViewModel($0))
            }
        }
    }
    
    func fill(with viewModel: CompletedOrderViewModel) {
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
