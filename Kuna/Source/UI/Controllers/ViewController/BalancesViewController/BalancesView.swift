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
        static let tabName                      = "My Balances"
        static let switchText                   = "Show empty"
        static let switchWidth                  = 100
        static let switchHeight                 = 33
        static let viewHorizontalGap: CGFloat   = 10
        static let viewVerticalGap: CGFloat     = 5
    }
    
    // IBOutlets
    
    @IBOutlet var balancesTableView: UITableView?
    
    // MARK: Public Properties
    
    var switchView: SwitchView?
    
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
        
        guard let headerView = self.headerView else { return }
        
        let switchView = UINib.object(with: SwitchView.self, bundle: .main)
        let size = CGSize(width: Constants.switchWidth, height: Constants.switchHeight)
        let origin = CGPoint(x: headerView.frame.width
                                - size.width
                                - (headerView.marketView?.frame.width ?? 0)
                                - Constants.viewHorizontalGap,
                             y: headerView.frame.height - size.height - Constants.viewVerticalGap)
        
        switchView.frame = CGRect(origin: origin, size: size)
        switchView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        switchView.switchLabel?.text = Constants.switchText
        
        self.switchView = switchView
        headerView.addSubview(switchView)
    }
}
