//
//  UserOrderCell.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 03/03/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserOrderCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet var priceLabel: UILabel?
    @IBOutlet var countMainCurrencyLabel: UILabel?
    @IBOutlet var countSecondCurrencyLabel: UILabel?
    @IBOutlet var orderSideImageView: UIImageView?
    
    // MARK Public Properties
    
    var order: ActiveOrderModel? {
        willSet {
            newValue.map { [weak self] in
                self?.fill(with: ActiveOrderViewModel($0))
            }
        }
    }
    
    // MARK: View Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.priceLabel?.text = nil
        self.countMainCurrencyLabel?.text = nil
        self.countSecondCurrencyLabel?.text = nil
    }
    
    // MARK: Public Methods
    
    func fill(with viewModel: ActiveOrderViewModel) {
        self.priceLabel?.text = viewModel.price
        self.countMainCurrencyLabel?.text = viewModel.volumeMainCurrency
        self.countSecondCurrencyLabel?.text = viewModel.volumeSecondCurrency
    }
}
