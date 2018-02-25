//
//  ControllerViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 30/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ControllerViewModel {
    
    // MARK: Public Properties
    
    let disposeBag = DisposeBag()
    let marketSubject = PublishSubject<MarketModel>()
    let selectMarketSubject = PublishSubject<Void>()
    
    var currentUser: CurrentUserModel
    var market: MarketModel? {
        didSet {
            if let market = self.market {
                self.updateData()
                self.marketSubject.onNext(market)
            }
        }
    }
    
    // MARK: Initialization
    
    init(_ currentUserModel: CurrentUserModel) {
        self.currentUser = currentUserModel
    }
    
    // MARK: Public Methods
    
    func updateData() {
        guard let unwrappedMarket = self.market else { return }
        
        self.updateModelFromDbData(with: unwrappedMarket)
        self.executeContext(with: unwrappedMarket)
    }
    
    func executeContext(with market: MarketModel) {
        
    }
    
    func updateModelFromDbData(with market: MarketModel) {
       
    }
    
    func updateDbData(with array: [DBModel]) {
        for order in array {
            order.update()
        }
    }
    
    func configureFilter(with market: MarketModel) -> NSPredicate {
        return NSPredicate(format: "market = %@", market.marketName)
    }
}
