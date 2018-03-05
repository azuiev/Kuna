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
    
    @IBOutlet var windowNameLabel:  UILabel?
    @IBOutlet var tabNameLabel:     UILabel?
    @IBOutlet var exitButton:       UIButton?
    
    // MARK: Public Properties
    
    var marketTapGestureRecognizer: UITapGestureRecognizer?
    var marketView: MarketView?
    
    // Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureLayer()
    }
    
    // MARK: Private functiona
    
    private func configureLayer() {
        let layer = self.layer
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
    }
}
