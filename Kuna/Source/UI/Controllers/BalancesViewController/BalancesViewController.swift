//
//  BalancesViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 21/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Protocol UITableViewDataSource

extension BalancesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainViewModel.balances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: BalanceCell.self, indexPath: indexPath)
        
        cell.balance = self.mainViewModel.balances[indexPath.row]
        
        return cell
    }
}

// MARK: Protocol UITableViewDelegate

extension BalancesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}

// MARK: Protocol ViewViewModel

extension BalancesViewController: ViewViewModel {
    typealias ViewType = BalancesView
    typealias ViewModelType = BalancesViewModel
}

class BalancesViewController: ViewController {

    // MARK: Initialization
    
    init(_ viewModel: BalancesViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.fill(with: self.mainViewModel)
        
        let nib = UINib(nibName: toString(BalanceCell.self), bundle: .main)
        
        self.rootView?.tableView?.register(nib, forCellReuseIdentifier: toString(BalanceCell.self))
    }
}
