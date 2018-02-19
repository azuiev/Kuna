//
//  OrdersViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 19/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Protocol UITableViewDataSource

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainViewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: OrderCell.self, indexPath: indexPath)
        
        cell.order = self.mainViewModel.orders[indexPath.row]
        
        return cell
    }
}

// MARK: Protocol UITableViewDelegate

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}

// MARK: Protocol ViewViewModel

extension OrdersViewController: ViewViewModel {
    typealias ViewType = OrdersView
    typealias ViewModelType = OrdersViewModel
}

class OrdersViewController: ViewController {

    // MARK: View Lifecycle
    
    init(_ viewModel: OrdersViewModel) {
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.fill(with: self.mainViewModel)
        
        let nib = UINib(nibName: toString(OrderCell.self), bundle: .main)
        
        self.rootView?.tableView?.register(nib, forCellReuseIdentifier: toString(OrderCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mainViewModel.updateOrders()
    }
    
    // MARK: Private Methods
    
    private func parseOrders(with jsonArray: JSONArray) {
        let orders = OrdersResponseParser().createAndUpdateOrdersWith(jsonArray: jsonArray)
        self.mainViewModel.fill(with: orders)
    }
}
