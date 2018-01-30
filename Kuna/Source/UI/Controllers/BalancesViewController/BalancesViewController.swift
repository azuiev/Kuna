//
//  BalancesViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 21/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class BalancesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Public Properties
    
    var viewModel: BalancesViewModel
    
    var rootView: BalancesView? {
        return self.viewIfLoaded as? BalancesView
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
        
        let nib = UINib(nibName: toString(CurrencyCell.self), bundle: .main)
        
        self.rootView?.tableView?.register(nib, forCellReuseIdentifier: toString(CurrencyCell.self))
    }
    
    // MARK: Private Methods
    
    private func finishLogging(with result: Result<JSON>) {
        print("\(result)")
    }
    
    // MARK: protocol UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.balances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: CurrencyCell.self, indexPath: indexPath)
        
        cell.balance = self.viewModel.balances[indexPath.row]
       
        return cell
    }
    
    /*
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.row == destinationIndexPath.row { return }
        
        self.friends.moveRow(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
        self.rootView.tableView?.reloadData()
    }
    */
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    // MARK: protocol UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         self.friends[indexPath.row]
         .map { UserViewController(model: $0, currentUser: user) }
         .map { [weak self] in
         self?.navigationController?.pushViewController($0, animated: true)
         }
         */
    }
}
