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
        if tableView == self.rootView?.buyOrders  {
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
        cell = tableView.reusableCell(with: OrderCell.self, indexPath: indexPath)
        
        if tableView == self.rootView?.buyOrders {
            cell.order = self.mainViewModel.buyOrders[indexPath.row]
        }
        
        if tableView == self.rootView?.sellOrders {
            cell.order = self.mainViewModel.sellOrders[indexPath.row]
        }
        
        if tableView == self.rootView?.tradings {
            cell.trading = self.mainViewModel.tradings[indexPath.row]
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
                        self?.parseOrders(with: $0)
                    }
                }
            }
            .disposed(by: self.mainViewModel.disposeBag)
        
        self.mainViewModel.tradingsResult
            .asObservable()
            .subscribe {
                _ = $0.map { [weak self] in
                    self?.check(response: $0) { [weak self] in
                        self?.parseTradings(with: $0 as! JSONArray)
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
        
        let nib = UINib(nibName: toString(OrderCell.self), bundle: .main)
        
        self.rootView?.buyOrders?.register(nib, forCellReuseIdentifier: toString(OrderCell.self))
        self.rootView?.sellOrders?.register(nib, forCellReuseIdentifier: toString(OrderCell.self))
        self.rootView?.tradings?.register(nib, forCellReuseIdentifier: toString(OrderCell.self))
    }

    // MARK: Private Methods
    
    private func parseOrders(with json: JSON) {
        let orders = OrdersResponseParser().createAndUpdateOrdersWith(json: json)
        self.mainViewModel.fillOrders(with: OrdersModel(orders: orders))
    }
    
    private func parseTradings(with jsonArray: JSONArray) {
        let tradings = TradingsResponseParser().createAndUpdateTradingsWith(jsonArray: jsonArray)
        self.mainViewModel.fillTradings(with: tradings)
    }
}
