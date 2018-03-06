//
//  OrdersViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 19/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Protocol RootView

extension OrdersViewController: RootView {
    typealias ViewType = OrdersView
}

class OrdersViewController: ViewController<OrdersViewModel>, UITableViewDataSource, UITableViewDelegate {

    // MARK: Constants
    
    private enum Constants {
    static let deleteString = "Deleting..."
    }
    
    // MARK: Protocol UITableViewDelegate
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.showHUD(text: Constants.deleteString)
            
            self.viewModel.cancelOrder(with: indexPath.row)
        }
    }
    
    // MARK: Protocol UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: UserOrderCell.self, indexPath: indexPath)
        
        cell.order = self.viewModel.orders[indexPath.row]
        
        return cell
    }
    
    // MARK: Initialization
    
    override init(_ viewModel: OrdersViewModel) {
        super.init(viewModel)
        
        viewModel.cancelOrderResult
            .asObservable()
            .subscribe {
                _ = $0.map { [weak self] in
                    self?.check(response: $0) { [weak self] in
                        self?.parseOrder(with: $0)
                    }
                }
            }
            .disposed(by: self.viewModel.disposeBag)
        
        viewModel.ordersResult
            .asObservable()
            .subscribe {
                _ = $0.map { [weak self] in
                    self?.check(response: $0) { [weak self] in
                        self?.parseOrders(with: $0)
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
        
        let view = self.rootView
        view?.fill(with: self.viewModel)
        
        let nib = UINib(nibName: toString(UserOrderCell.self), bundle: .main)
        
        view?.ordersTableView?.register(nib, forCellReuseIdentifier: toString(UserOrderCell.self))
        view?.ordersTableView?.allowsMultipleSelectionDuringEditing = false
    }
    
    // MARK: Private Methods
    
    private func parseOrders(with jsonArray: JSONArray) {
        let orders = OrdersParser().createAndUpdateOrdersWith(type: ActiveOrderModel.self, jsonArray: jsonArray)
        self.viewModel.fill(with: orders)
    }
    
    private func parseOrder(with json: JSON) {
        let order = OrdersParser().order(orderType: ActiveOrderModel.self, json: json)
        order.map { [weak self] in
            self?.viewModel.delete(order: $0)
        }
    }
}
