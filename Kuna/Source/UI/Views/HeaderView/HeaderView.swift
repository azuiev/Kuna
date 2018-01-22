//
//  HeaderView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 22/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    // MARK: IBOutlets
    
    @IBOutlet var appNameLabel:         UILabel?
    @IBOutlet var controllerNameLabel:  UILabel?
    
    
    // Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
