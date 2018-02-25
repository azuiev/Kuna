//
//  TradingsViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 03/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Protocol RootView

extension TradingsViewController: RootView {
    typealias ViewType = TradingsView
}

class TradingsViewController: ViewController<TradingsViewModel>, UITableViewDataSource {

    // MARK:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.rootView?.buyOrders  {
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
        if tableView == self.rootView?.buyOrders  {
            let cell = tableView.reusableCell(with: OrderCell.self, indexPath: indexPath)
            cell.order = self.viewModel.buyOrders[indexPath.row]
            
            return cell
        }
        
        if tableView == self.rootView?.sellOrders {
            let cell = tableView.reusableCell(with: OrderCell.self, indexPath: indexPath)
            cell.order = self.viewModel.sellOrders[indexPath.row]
            
            return cell
        }
        
        if tableView == self.rootView?.tradings {
            let cell = tableView.reusableCell(with: CompletedOrderCell.self, indexPath: indexPath)
            cell.order = self.viewModel.tradings[indexPath.row]
            
            return cell
        }
        
        return tableView.reusableCell(with: OrderCell.self, indexPath: indexPath)
    }
    // MARK: Initialization
    
    override init(_ viewModel: TradingsViewModel) {
        super.init(viewModel)
        
        self.viewModel.newOrderSubject
            .asObservable()
            .subscribe { [weak self] _ in
                if let currentUser = self?.viewModel.currentUser {
                    let controller = NewOrderViewController(ViewModel(currentUser)) { 
                        print($0)
                    }
                    
                    controller.modalPresentationStyle = .overCurrentContext
                    self?.present(controller, animated: true)
                }
            }
            .disposed(by: self.viewModel.disposeBag)
        
        self.viewModel.ordersResult
            .asObservable()
            .subscribe {
                _ = $0.map { [weak self] in
                    self?.check(response: $0) { [weak self] in
                        self?.parseOrders(with: $0)
                    }
                }
            }
            .disposed(by: self.viewModel.disposeBag)
        
        self.viewModel.tradingsResult
            .asObservable()
            .subscribe {
                _ = $0.map { [weak self] in
                    self?.check(response: $0) { [weak self] in
                        self?.parseTradings(with: $0)
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
        
        let nibOrderCell = UINib(nibName: toString(OrderCell.self), bundle: .main)
        let nibCompletedOrderCell = UINib(nibName: toString(CompletedOrderCell.self), bundle: .main)
        
        self.rootView?.buyOrders?.register(nibOrderCell, forCellReuseIdentifier: toString(OrderCell.self))
        self.rootView?.sellOrders?.register(nibOrderCell, forCellReuseIdentifier: toString(OrderCell.self))
        self.rootView?.tradings?.register(nibCompletedOrderCell, forCellReuseIdentifier: toString(CompletedOrderCell.self))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.viewModel.disableUpdating()
    }
    // MARK: Private Methods
    
    private func parseOrders(with json: JSON) {
        let orders = OrdersParser().createAndUpdateOrdersWith(type: ActiveOrderModel.self, json: json)
        self.viewModel.fillOrders(with: ActiveOrdersModel(orders: orders))
    }
    
    private func parseTradings(with jsonArray: JSONArray) {
        let tradings = OrdersParser().createAndUpdateOrdersWith(type: CompletedOrderModel.self, jsonArray: jsonArray)
        self.viewModel.fillTradings(with: tradings)
    }
}
