//
//  BalancesViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 24/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RxSwift

class BalancesViewModel: ControllerViewModel {
    
    // MARK: Public Properties
    
    let balancesResult = PublishSubject<Result<JSON>>()
    let balancesSubject = PublishSubject<Void>()
    
    override var market: MarketModel? {
        didSet { }
    }
    
    var balances: BalancesModel = BalancesModel() {
        didSet {
            self.balancesSubject.onNext(())
        }
    }

    // MARK: Initialization
    
    init(user: CurrentUserModel, balances: BalancesModel) {
        self.allBalances = balances.array
        
        super.init(user)
    }
    
    // MARK: Private Properties
    
    private var displayEmpty: Bool = true {
        willSet {
            if newValue {
                self.balances = BalancesModel(array: self.allBalances)
            } else {
                self.balances = BalancesModel(array: self.allBalances.filter { $0.count > 0 })
            }
        }
    }
    
    private var allBalances: [BalanceModel] {
        willSet {
            if self.displayEmpty {
                self.balances = BalancesModel(array: newValue)
            } else {
                self.balances = BalancesModel(array: newValue.filter { $0.count > 0 })
            }
        }
    }
    
    // MARK: Public Methods
    
    func showEmpty(_ flag: Bool) {
        self.displayEmpty = flag
    }
    
    override func updateData() {
         self.executeContext()
    }
    
    func executeContext() {
        LoginContext(user: self.currentUser).execute(with: JSON.self) { [weak self] in
            self?.balancesResult.onNext($0)
        }
    }
    
    func fill(with balances: BalancesModel) {
        self.allBalances = balances.array
    }
}
