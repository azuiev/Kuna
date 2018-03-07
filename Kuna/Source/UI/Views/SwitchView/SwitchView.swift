//
//  SwitchView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 07/03/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class SwitchView: UIView {

    // MARK: IBOutlets
    
    @IBOutlet var switchButton: UISwitch?
    @IBOutlet var switchLabel: UILabel?
    
    // MARK Public Methods
    
    func fill(with viewModel: BalancesViewModel) {
        print("Add observing")
    }
}
