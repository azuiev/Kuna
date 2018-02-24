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

class OrdersViewController: ViewController<OrdersViewModel>, UITableViewDataSource {

    // MARK: Protocol UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: OrderCell.self, indexPath: indexPath)
        
        cell.order = self.viewModel.orders[indexPath.row]
        
        return cell
    }
    
    // MARK: Initialization
    
    override init(_ viewModel: OrdersViewModel) {
        super.init(viewModel)
        
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.fill(with: self.viewModel)
        
        let nib = UINib(nibName: toString(OrderCell.self), bundle: .main)
        
        self.rootView?.tableView?.register(nib, forCellReuseIdentifier: toString(OrderCell.self))
    }
    
    // MARK: Private Methods
    
    private func parseOrders(with jsonArray: JSONArray) {
        let orders = OrdersResponseParser().createAndUpdateOrdersWith(jsonArray: jsonArray)
        self.viewModel.fill(with: orders)
    }
}
