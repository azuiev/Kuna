//
//  BalancesView
//  Kuna
//
//  Created by Aleksey Zuiev on 21/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BalancesView: MainView {

    // MARK: Constants
    
    private struct Constants {
        static let tabName = "My Balances"
    }
    
    // IBOutlets
    
    @IBOutlet var balancesTableView: UITableView?
    
    // MARK: Public Properties
    
    override var tabName: String { return Constants.tabName }
    
    // MARK: Public Methods
    
    func fill(with viewModel: BalancesViewModel) {
        super.fill(with: viewModel)
        
        viewModel.balancesSubject
            .asObservable()
            .skip(1)
            .subscribe({ [weak self] _ in
                self?.balancesTableView?.reloadData()
            })
            
            .disposed(by: self.disposeBag)
    }
}
