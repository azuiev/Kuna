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
        
        self.viewModel.balancesResult
            .asObservable()
            .subscribe({
                _ = $0.map { [weak self] in
                    self?.check(response:$0) { [weak self] in
                        self?.parse(json: $0)
                    }
                }
            })
            .disposed(by: self.disposeBag)
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
    
    // MARK: Private Methods
    
    private func parse(json: JSON) {
        let balances = LoginResponseParser().update(user: self.viewModel.currentUser, with: json)
        
        self.viewModel.fill(with: balances)
    }
}
