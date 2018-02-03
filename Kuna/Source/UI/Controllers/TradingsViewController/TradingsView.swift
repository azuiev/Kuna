//
//  TradingsView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 03/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

class TradingsView: MainView {
    
    // MARK: Constants
    
    private struct Constants {
        static let tabName = "Tradings"
    }
    
    // IBOutlets
    
    @IBOutlet var tableView: UITableView?
    
    // MARK: Public Properties
    
    override var tabName: String { return Constants.tabName }
    
    let disposeBag = DisposeBag()
    
    // MARK: Public Methods
    
    func fill(with viewModel:BalancesViewModel) {
        
    }
}
