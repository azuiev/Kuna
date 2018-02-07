//
//  TradingsView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 03/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

enum TableType: Int {
    case buyTable       = 0
    case sellTable      = 1
    case tradingsTable  = 2
}

class TradingsView: MainView {
    
    // MARK: Constants
    
    private struct Constants {
        static let tabName = "Tradings"
    }
    
    // IBOutlets
    
    @IBOutlet var buyOrders: UITableView?
    @IBOutlet var sellOrders: UITableView?
    @IBOutlet var tradings: UITableView?
    @IBOutlet var segmentedView: UISegmentedControl?
    
    // MARK: Public Properties
    
    override var tabName: String { return Constants.tabName }
    
    let disposeBag = DisposeBag()
    
    // MARK: Public Methods
    
    func fill(with viewModel: TradingsViewModel) {
        _ = self.segmentedView?
            .rx
            .value
            .asObservable()
            .subscribe({ [weak self] in
                guard let tableType = TableType(rawValue: $0.element ?? 0) else { return }
                viewModel.onSelectSegment(with: tableType)
                
                let view: UITableView?
                
                switch tableType {
                case .buyTable:  view = self?.buyOrders
                case .sellTable:  view = self?.sellOrders
                case .tradingsTable:  view = self?.tradings
                
                view.map { [weak self] in
                    self?.bodyView?.bringSubview(toFront: $0)
                    }
                }
                }
            )
            .disposed(by: self.disposeBag)
        
        _ = viewModel.buyOrdersVariable.asObservable().subscribe {
            print("TEST1")
        }
        
        _ = viewModel.sellOrdersVariable.asObservable().subscribe {
            print("TEST1")
        }
        
        _ = viewModel.tradingsVariable.asObservable().subscribe {
            print("TEST1")
        }
    }
}
