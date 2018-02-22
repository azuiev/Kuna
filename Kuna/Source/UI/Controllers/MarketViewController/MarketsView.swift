//
//  MarketsView
//  Kuna
//
//  Created by Aleksey Zuiev on 21/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MarketsView: UIView {

    // IBOutlets
    
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var cancelButton: UIButton?
    
    // MARK: Public Methods
    
    func fill(with viewModel: OrdersViewModel) {
        
    }
}
