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

    // MARK: Constants
    
    private struct Constants {
        static let tabName = "History"
    }
    
    // IBOutlets
    
    @IBOutlet var tableView: UITableView? 
    
    // MARK: Public Properties
    
    override var tabName: String { return Constants.tabName }
    
    // MARK: View Lifecycle
    override func awakeFromNib() {
        super .awakeFromNib()
        

    }
    
    // MARK: Public Methods
    
    func fill(with viewModel: HistoryViewModel) {
        super.fill(with: viewModel)
        
        viewModel.ordersSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.tableView?.reloadData()
            })
            
            .disposed(by: self.disposeBag)
    }
}
