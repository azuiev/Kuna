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
        return 6
            //self.viewModel.balances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: OrderCell.self, indexPath: indexPath)
        
        cell.balance = self.viewModel.balances[indexPath.row]
        
        return cell
    }
}

// MARK: Protocol UITableViewDelegate

extension TradingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    // MARK: protocol UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

class TradingsViewController: UIViewController {

    // MARK: Public Properties
    
    var viewModel: BalancesViewModel
    
    var rootView: TradingsView? {
        return self.viewIfLoaded as? TradingsView
    }
    
    // MARK: Initialization
    
    init(_ viewModel: BalancesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: toString(type(of: self)), bundle: .main)
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

}
