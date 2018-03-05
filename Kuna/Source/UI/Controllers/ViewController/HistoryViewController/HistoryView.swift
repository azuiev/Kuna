//
//  historyView
//  Kuna
//
//  Created by Aleksey Zuiev on 19/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryView: MainView {

    // MARK: Protocol TableView
    
    override var tableView: [UITableView] {
        if let view = self.historyTableView {
            return [view]
        }
        
        return super.tableView
    }
    
    // MARK: Constants
    
    private struct Constants {
        static let tabName = "History"
    }
    
    // IBOutlets
    
    @IBOutlet var historyTableView: UITableView?
    
    // MARK: Public Properties
    
    override var tabName: String { return Constants.tabName }
    
    // MARK: Public Methods
    
    func fill(with viewModel: HistoryViewModel) {
        super.fill(with: viewModel)
        
        viewModel.ordersSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.historyTableView?.reloadDataAndHideHud()
            })
            
            .disposed(by: self.disposeBag)
    }
}
