//
//  OrdersView
//  Kuna
//
//  Created by Aleksey Zuiev on 19/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OrdersView: MainView {

    // MARK: Protocol TableView
    
    override var tableView: [UITableView] {
        if let view = self.ordersTableView {
            return [view]
        }
        
        return super.tableView
    }
    
    // MARK: Constants
    
    private struct Constants {
        static let tabName = "My Orders"
    }
    
    // IBOutlets
    
    @IBOutlet var ordersTableView: UITableView?
    
    // MARK: Public Properties
    
    override var tabName: String { return Constants.tabName }
    
    // MARK: Public Methods
    
    func fill(with viewModel: OrdersViewModel) {
        super.fill(with: viewModel)
        
        viewModel.ordersSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.ordersTableView?.reloadDataAndHideHud()

            })
            
            .disposed(by: self.disposeBag)
        
        viewModel.cancelOrdersSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.ordersTableView?.reloadDataAndHideHud()
            })
            .disposed(by: self.disposeBag)
    }
}
