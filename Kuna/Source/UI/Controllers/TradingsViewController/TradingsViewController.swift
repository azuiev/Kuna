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
            return self.mainViewModel.buyOrders.count
        }
        
        if tableView == self.rootView?.sellOrders {
            return self.mainViewModel.sellOrders.count
        }
        
        if tableView == self.rootView?.tradings {
            return self.mainViewModel.tradings.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = OrderCell()
        
        if tableView == self.rootView?.buyOrders {
            cell = tableView.reusableCell(with: BuyOrderCell.self, indexPath: indexPath)
            
            cell.order = self.mainViewModel.buyOrders[indexPath.row]
        }
        
        if tableView == self.rootView?.sellOrders {
            cell = tableView.reusableCell(with: SellOrderCell.self, indexPath: indexPath)
            
            cell.order = self.mainViewModel.sellOrders[indexPath.row]
        }
        
        if tableView == self.rootView?.sellOrders {
            cell = tableView.reusableCell(with: SellOrderCell.self, indexPath: indexPath)
            
            cell.order = self.mainViewModel.sellOrders[indexPath.row]
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

// MARK: Protocol ViewViewModel

extension TradingsViewController: ViewViewModel {
    typealias ViewType = TradingsView
    typealias ViewModelType = TradingsViewModel
}

class TradingsViewController: ViewController {

    // MARK: Enum
    
    private enum ResultType {
        case orders
        case tradings
    }
    
    // MARK: Initialization
    
    init(_ viewModel: TradingsViewModel) {
        super.init(viewModel)
        
        self.mainViewModel.ordersResult
            .asObservable()
            .subscribe {
                _ = $0.map { [weak self] in
                    self?.check(response: $0) { [weak self] in
                        self?.parse(json: $0, with: ResultType.orders)
                    }
                }
            }
            .disposed(by: self.mainViewModel.disposeBag)
        
        self.mainViewModel.tradingsResult
            .asObservable()
            .subscribe {
                _ = $0.map { [weak self] in
                    self?.check(response: $0) { [weak self] in
                        self?.parse(json: $0, with: ResultType.tradings)
                    }
                }
            }
            .disposed(by: self.mainViewModel.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.fill(with: self.mainViewModel)
        
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
            
            self.mainViewModel.fillOrders(with: orders)
        case .tradings:
            let tradings = TradingsResponseParser().createAndUpdateTradingsWith(json: json)
            
            self.mainViewModel.fillTradings(with: tradings)
        }
    }
}
