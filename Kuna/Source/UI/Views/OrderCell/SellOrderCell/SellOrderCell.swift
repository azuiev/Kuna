//
//  SellOrderCell.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 03/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class SellOrderCell: OrderCell {

    // MARK: IBOutlets

    @IBOutlet var currencyName: UILabel?
    @IBOutlet var count: UILabel?
    
    override func fill(with viewModel: OrderViewModel) {
        self.currencyName?.text = viewModel.code
        self.count?.text = viewModel.count
    }
}
