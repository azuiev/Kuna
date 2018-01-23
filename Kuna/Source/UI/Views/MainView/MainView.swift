//
//  MainView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 23/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class MainView: UIView {

    // MARK: Constants
    
    private struct Constants {
        static let windowName = "Kuna"
        static let tabName = "Main"
    }
    
    // MARK: Public Properteis
    
    var tabName: String { return Constants.tabName }
    
    // MARK: Private Properties
    
    private var windowName: String { return Constants.windowName }
    private var headerView: HeaderView?
    
    // MARK: UI Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let view = UINib.object(with: HeaderView.self, bundle: .main)
        
        self.headerView = view
        self.setWindowLabelText()
        
        self.addSubview(view)
    }

    // Private Methods
    
    private func setWindowLabelText() {
        self.headerView.map { [weak self] in
            $0.windowNameLabel?.text = self?.windowName
            $0.tabNameLabel?.text = self?.tabName
        }
    }
}
