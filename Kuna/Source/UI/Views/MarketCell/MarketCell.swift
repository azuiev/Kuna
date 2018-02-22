//
//  MarketCell.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 22/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class MarketCell: UICollectionViewCell {

    // MARK: IBOutlets
    
    @IBOutlet var mainCurrencyLabel: UILabel?
    @IBOutlet var secondCurrencyLabel: UILabel?
    
    // MARK Public Properties
    
    var market: MarketModel? {
        willSet {
            newValue.map { [weak self] in
                self?.fill(with: MarketViewModel($0))
            }
        }
    }
    
    func fill(with viewModel: MarketViewModel) {
        self.mainCurrencyLabel?.text = viewModel.mainCurrencyName
        self.secondCurrencyLabel?.text = viewModel.secondCurrencyName
    }
}
