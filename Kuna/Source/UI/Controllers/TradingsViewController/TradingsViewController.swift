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
        if tableView == self.rootView?.buyOrders {
            return 5
        }
        
        if tableView == self.rootView?.sellOrders {
            return 6
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = OrderCell()
        
        if tableView == self.rootView?.buyOrders {
            cell = tableView.reusableCell(with: BuyOrderCell.self, indexPath: indexPath)
            
            cell.balance = self.viewModel.buyOrders[indexPath.row]
        }
        
        if tableView == self.rootView?.sellOrders {
            cell = tableView.reusableCell(with: SellOrderCell.self, indexPath: indexPath)
            
            cell.balance = self.viewModel.sellOrders[indexPath.row]
        }
        
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

class TradingsViewController: ViewController {

    // MARK: Public Properties
    
    var viewModel: TradingsViewModel
    
    var rootView: TradingsView? {
        return self.viewIfLoaded as? TradingsView
    }
    
    // MARK: Initialization
    
    init(_ viewModel: TradingsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: toString(type(of: self)), bundle: .main)
        
        self.viewModel.tradingsResult
            .asObservable()
            .subscribe({
                _ = $0.map { [weak self] in
                    self?.check(result: $0)
                }
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibBuyCell = UINib(nibName: toString(BuyOrderCell.self), bundle: .main)
        let nibSellCell = UINib(nibName: toString(SellOrderCell.self), bundle: .main)

        self.rootView?.buyOrders?.register(nibBuyCell, forCellReuseIdentifier: toString(BuyOrderCell.self))
        self.rootView?.sellOrders?.register(nibSellCell, forCellReuseIdentifier: toString(SellOrderCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.rootView?.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.rootView?.stopTimer()
    }
    // MARK: Public Methods
    
    override func parse(json: JSON) {
        let balances = LoginResponseParser().update(user: self.viewModel.currentUser, with: json)
        
        self.fillTable(with: balances)
    }
    
    // MARK: Private Methods
    
    private func fillTable(with json: BalancesModel) {
        
    }
}
