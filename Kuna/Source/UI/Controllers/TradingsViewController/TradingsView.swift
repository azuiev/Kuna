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

    // MARK: Public Methods
    
    func fill(with viewModel: TradingsViewModel) {
        super.fill(with: viewModel)
        
        self.segmentedView?
            .rx
            .value
            .asObservable()
            .subscribe({[weak self] in
                guard let tableType = TableType(rawValue: $0.element ?? 0) else { return }
                viewModel.onSelectSegment(with: tableType)
                
                let view: UITableView?
                
                switch tableType {
                case .buyTable: view = self?.buyOrders
                case .sellTable: view = self?.sellOrders
                case .tradingsTable: view = self?.tradings
                }
                
                view.map { [weak self] in
                    self?.bodyView?.bringSubview(toFront: $0)
                }
            })
            .disposed(by: self.disposeBag)
        
        viewModel.buyOrdersSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.buyOrders?.reloadData()
            })
                
            .disposed(by: self.disposeBag)
        
        viewModel.sellOrdersSubject
            .asObservable()
            .subscribe({ [weak self] _ in
               self?.sellOrders?.reloadData()
            })
            .disposed(by: self.disposeBag)
        
        viewModel.tradingsSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.tradings?.reloadData()
            })
            .disposed(by: self.disposeBag)
    }
}
