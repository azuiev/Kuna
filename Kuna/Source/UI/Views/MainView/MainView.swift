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
    
    // MARK: IBOutlets
    
    @IBOutlet var bodyView: UIView?
    
    // MARK: Public Properties
    
    var tabName: String { return Constants.tabName }
    
    // MARK: Private Properties
    
    private var windowName: String { return Constants.windowName }
    var headerView: HeaderView?
    
    // MARK: UI Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let headerView = UINib.object(with: HeaderView.self, bundle: .main)
        self.addSubview(headerView)
        
        let height = UIScreen.main.bounds.height
        let headerHeight = height / 5
        let bodyHeight = height - headerHeight
        let bodyView = self.bodyView
        
        headerView.frame.size.height = headerHeight
        bodyView?.frame.size.height = bodyHeight
        bodyView?.frame.origin.y = headerHeight
        
        self.headerView = headerView
        self.setWindowLabelText()
    }

    // Private Methods
    
    private func setWindowLabelText() {
        self.headerView.map { [weak self] in
            $0.windowNameLabel?.text = self?.windowName
            $0.tabNameLabel?.text = self?.tabName
        }
    }
}
