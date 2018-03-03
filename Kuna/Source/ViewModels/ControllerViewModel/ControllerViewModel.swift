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
        
        let marketName = unwrappedMarket.marketName
        self.updateModelFromDbData(with: marketName)
        self.executeContext(with: marketName)
    }
    
    func executeContext(with marketName: String) {
        
    }
    
    func updateModelFromDbData(with marketName: String) {
       
    }
    
    func updateDbData(with array: [DBModel]) {
        for order in array {
            order.update()
        }
    }
    
    func configureFilter(marketName: String, userOrder: Bool? = nil) -> NSPredicate {
        if let unwrappedBool = userOrder {
            return NSPredicate(format: "market = %@ AND currentUserOrder = %@", marketName, NSNumber(value: unwrappedBool))
        }
        
        return NSPredicate(format: "market = %@", marketName)
    }
}
