//
//  MarketViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 21/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

// MARK: Protocol ViewViewModel

extension NewOrderViewController: RootView {
    typealias ViewType = NewOrderView
}

class NewOrderViewController: ViewController<NewOrderViewModel> {

    // MARK: Initialization
    
    override init(_ viewModel: NewOrderViewModel) {
        super.init(viewModel)
        
        viewModel.newOrderResult
            .asObservable()
            .subscribe {
                _ = $0.map { [weak self] in
                    self?.check(response: $0) { [weak self] in
                        self?.parseOrder(with: $0)
                    }
                }
            }
            .disposed(by: self.viewModel.disposeBag)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.fill(with: self.viewModel)
        
        self.rootView?.cancelButton?
            .rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
    // MARK: Private Methods

    private func parseOrder(with json: JSON) {
        let order = OrdersParser().order(orderType: ActiveOrderModel.self, json: json)
        self.dismiss(animated: true) {
            order.map { [weak self] in
                self?.viewModel.completion($0)
            }
        }
    }
}
