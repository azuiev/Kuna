//
//  BalancesViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 21/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Protocol RootView

extension BalancesViewController: RootView {
    typealias ViewType = BalancesView
}

class BalancesViewController: ViewController<BalancesViewModel>, UITableViewDataSource {

    // MARK: Protocol UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.balances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: BalanceCell.self, indexPath: indexPath)
        
        cell.balance = self.viewModel.balances[indexPath.row]
        
        return cell
    }
    
    // MARK: Initialization
    
    override init(_ viewModel: BalancesViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let balancesView = self.rootView
        balancesView?.fill(with: self.viewModel)
    
        let nib = UINib(nibName: toString(BalanceCell.self), bundle: .main)
        
        balancesView?.balancesTableView?.register(nib, forCellReuseIdentifier: toString(BalanceCell.self))
    }
}
