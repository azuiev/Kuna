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
    
    @IBOutlet var tableView: UITableView?
    
    // MARK: Public Properties
    
    override var tabName: String { return Constants.tabName }
}
