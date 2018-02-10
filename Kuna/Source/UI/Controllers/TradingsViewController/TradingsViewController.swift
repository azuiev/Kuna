//
//  TradingsViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 03/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
// MARK: Protocol UITableViewDataSource

extension  TradingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.rootView?.buyOrders {
            return self.viewModel.buyOrders.count
        }
        
        if tableView == self.rootView?.sellOrders {
            return self.viewModel.sellOrders.count
        }
        
        if tableView == self.rootView?.tradings {
            return self.viewModel.tradings.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = OrderCell()
        
        if tableView == self.rootView?.buyOrders {
            cell = tableView.reusableCell(with: BuyOrderCell.self, indexPath: indexPath)
            
            cell.order = self.viewModel.buyOrders[indexPath.row]
        }
        
        if tableView == self.rootView?.sellOrders {
            cell = tableView.reusableCell(with: SellOrderCell.self, indexPath: indexPath)
            
            cell.order = self.viewModel.sellOrders[indexPath.row]
        }
        
        if tableView == self.rootView?.sellOrders {
            cell = tableView.reusableCell(with: SellOrderCell.self, indexPath: indexPath)
            
            cell.order = self.viewModel.sellOrders[indexPath.row]
        }
        
        return cell
    }
}

// MARK: Protocol UITableViewDelegate

extension TradingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

class TradingsViewController: ViewController {

    // MARK: Enum
    
    private enum ResultType {
        case orders
        case tradings
    }
    
    // MARK: Public Properties
    
    var viewModel: TradingsViewModel
    
    var rootView: TradingsView? {
        return self.viewIfLoaded as? TradingsView
    }
    
    // MARK: Initialization
    
    init(_ viewModel: TradingsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: toString(type(of: self)), bundle: .main)
        
        self.viewModel.ordersResult
            .asObservable()
            .subscribe {
                _ = $0.map { [weak self] in
                    self?.check(result: $0) { [weak self] in
                        self?.parse(json: $0, with: ResultType.orders)
                    }
                }
            }
            .disposed(by: self.viewModel.disposeBag)
        
        self.viewModel.tradingsResult
            .asObservable()
            .subscribe {
                _ = $0.map { [weak self] in
                    self?.check(result: $0) { [weak self] in
                        self?.parse(json: $0, with: ResultType.tradings)
                    }
                }
            }
            .disposed(by: self.viewModel.disposeBag)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.fill(with: self.viewModel)
        
        let nibBuyCell = UINib(nibName: toString(BuyOrderCell.self), bundle: .main)
        let nibSellCell = UINib(nibName: toString(SellOrderCell.self), bundle: .main)

        self.rootView?.buyOrders?.register(nibBuyCell, forCellReuseIdentifier: toString(BuyOrderCell.self))
        self.rootView?.sellOrders?.register(nibSellCell, forCellReuseIdentifier: toString(SellOrderCell.self))
    }

    // MARK: Private Methods
    
    private func parse(json: JSON, with type: ResultType) {
        switch type {
        case .orders:
            let orders = OrdersResponseParser().createAndUpdateOrdersWith(json: json)
            
            self.viewModel.fillOrders(with: orders)
        case .tradings:
            let tradings = TradingsResponseParser().createAndUpdateTradingsWith(json: json)
            
            self.viewModel.fillTradings(with: tradings)
        }
    }
}
