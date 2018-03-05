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
    
    // MARK: Protocol TableView
    
    override var tableView: [UITableView] {
        var result = [UITableView]()
        if let view = self.buyOrdersTableView {
            result.append(view)
        }
        
        if let view = self.sellOrdersTableView {
            result.append(view)
        }
        
        if let view = self.tradingsTableView {
            result.append(view)
        }
        
        return result
    }
    
    // MARK: Constants
    
    private struct Constants {
        static let tabName = "Tradings"
    }
    
    // IBOutlets
    
    @IBOutlet var createOrder: UIButton?
    @IBOutlet var buyOrdersTableView: UITableView?
    @IBOutlet var sellOrdersTableView: UITableView?
    @IBOutlet var tradingsTableView: UITableView?
    @IBOutlet var segmentedView: UISegmentedControl?
    
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.createOrder?.layer.borderColor = UIColor(red: 0, green: 128, blue: 255).cgColor
    }
    
    // MARK: Public Properties
    
    override var tabName: String { return Constants.tabName }

    // MARK: Public Methods
    
    func fill(with viewModel: TradingsViewModel) {
        super.fill(with: viewModel)
        
        self.createOrder?
            .rx
            .tap
            .asObservable()
            .subscribe({ _ in
                viewModel.newOrderSubject.onNext(())
            })
            .disposed(by: self.disposeBag)
        
        self.segmentedView?
            .rx
            .value
            .asObservable()
            .subscribe({[weak self] in
                guard let tableType = TableType(rawValue: $0.element ?? 0) else { return }
                viewModel.onSelectSegment(with: tableType)
                
                let view: UITableView?
                
                switch tableType {
                case .buyTable: view = self?.buyOrdersTableView
                case .sellTable: view = self?.sellOrdersTableView
                case .tradingsTable: view = self?.tradingsTableView
                }
                
                view.map { [weak self] in
                    self?.bodyView?.bringSubview(toFront: $0)
                }
            })
            .disposed(by: self.disposeBag)
        
        viewModel.buyOrdersSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.buyOrdersTableView?.reloadDataAndHideHud()
            })
                
            .disposed(by: self.disposeBag)
        
        viewModel.sellOrdersSubject
            .asObservable()
            .subscribe({ [weak self] _ in
               self?.sellOrdersTableView?.reloadDataAndHideHud()
            })
            .disposed(by: self.disposeBag)
        
        viewModel.tradingsSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.tradingsTableView?.reloadDataAndHideHud()
            })
            .disposed(by: self.disposeBag)
    }
}
