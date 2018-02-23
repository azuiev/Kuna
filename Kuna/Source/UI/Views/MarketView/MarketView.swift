//
//  MarketView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 23/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class MarketView: UIView {

    // MARK: IBOutlets
    
    @IBOutlet var mainCurrencyImageView: UIImageView?
    @IBOutlet var secondCurrencyImageView: UIImageView?
    
    // MARK Public Properties
    
    var market: MarketModel? {
        willSet {
            newValue.map { [weak self] in
                self?.fill(with: MarketViewModel($0))
            }
        }
    }
    
    func fill(with viewModel: MarketViewModel) {
        self.mainCurrencyImageView?.image = viewModel.mainCurrencyImage
        self.secondCurrencyImageView?.image = viewModel.secondCurrencyImage
    }
}
