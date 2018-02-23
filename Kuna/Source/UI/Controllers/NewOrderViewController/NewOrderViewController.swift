//
//  MarketViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 21/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Protocol ViewViewModel

extension NewOrderViewController: RootView {
    typealias ViewType = NewOrderView
}

class NewOrderViewController: ViewController<ViewModel> {

    // MARK: Public Properties
    
    var order: OrderModel?
    var completion: (OrderModel) -> ()?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rootView?.cancelButton?
            .rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
    init(_ viewModel: ViewModel, completion: @escaping (OrderModel) -> ()) {
        self.completion = completion
                
        super.init(viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
