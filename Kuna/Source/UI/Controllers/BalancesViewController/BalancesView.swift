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

class BalancesView: BaseView {

    // MARK: IBOutlets
    
    @IBOutlet var testLabel: UILabel?
    
    // MARK: Public Properties
    
    let disposeBag = DisposeBag()
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: Public Methods
    
    func fill(with viewModel:LoginViewModel) {
        print("balances view")
    }
}
