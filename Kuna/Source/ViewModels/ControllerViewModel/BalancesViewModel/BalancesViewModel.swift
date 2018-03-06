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
    
    var balances: BalancesModel {
        didSet {
            self.balancesSubject.onNext(())
        }
    }

    // MARK: Initialization
    
    init(user: CurrentUserModel, balances: BalancesModel) {
        self.balances = balances
        
        super.init(user)
    }
    
    // MARK: Public Methods
    
    override func updateData() {
         self.executeContext()
    }
    
    func executeContext() {
        LoginContext(user: self.currentUser).execute(with: JSON.self) { [weak self] in
            self?.balancesResult.onNext($0)
        }
    }
    
    func fill(with balances: BalancesModel) {
        self.balances = balances
    }
}
