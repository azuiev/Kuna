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
        static let tabName      = "My Balances"
        static let switchText   = "Show empty"
    }
    
    // IBOutlets
    
    @IBOutlet var balancesTableView: UITableView?
    var switchView: SwitchView?
    
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
        
        self.switchView?.switchButton?
            .rx
            .value
            .asObservable()
            .subscribe(onNext: {
                viewModel.showEmpty($0)
            })
            .disposed(by: self.disposeBag)
    }
    
    override func setupHeaderItems() {
        super.setupHeaderItems()
        
        guard let unwrappedHeaderView = self.headerView else { return }
        
        let switchView = UINib.object(with: SwitchView.self, bundle: .main)
        let size = CGSize(width: 100, height: 33)
        let origin = CGPoint(x: unwrappedHeaderView.frame.width - size.width - 105,
                             y: unwrappedHeaderView.frame.height - size.height - 5)
        
        switchView.frame = CGRect(origin: origin, size: size)
        switchView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        switchView.switchLabel?.text = Constants.switchText
        
        self.switchView = switchView
        headerView?.addSubview(switchView)
    }
}
