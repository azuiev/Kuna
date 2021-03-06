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
    let logoutSubject = PublishSubject<Void>()
    let hudSubject = PublishSubject<Bool>()
    
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
    
    init(_ user: CurrentUserModel) {
        self.currentUser = user
    }
    
    // MARK: Public Methods
    
    func logout() {
        let realm = RealmService.shared
        realm.deleteObjectsWith(type: AccessTokenModel.self)
        realm.deleteObjectsWith(type: ActiveOrderModel.self)
        realm.deleteObjectsWith(type: HistoryOrderModel.self)
        realm.deleteObjectsWith(type: CompletedOrderModel.self)
        
        logoutSubject.onNext(())
    }
    
    func updateData() {
        guard let unwrappedMarket = self.market else { return }
        
        let marketName = unwrappedMarket.marketName
        self.clearTables()
        self.updateModelFromDbData(with: marketName)
        self.executeContext(with: marketName)
    }
    
    func clearTables() {
        self.hudSubject.onNext(true)
    }
    
    func executeContext(with marketName: String) {
        
    }
    
    func updateModelFromDbData(with marketName: String) {
       
    }
    
    func updateDbData(with array: [DBModel]) {
        for order in array {
            order.create()
        }
    }
    
    func configureFilter(marketName: String, userOrder: Bool? = nil) -> NSPredicate {
        if let unwrappedBool = userOrder {
            return NSPredicate(format: "market = %@ AND currentUserOrder = %@", marketName, NSNumber(value: unwrappedBool))
        }
        
        return NSPredicate(format: "market = %@", marketName)
    }
}
