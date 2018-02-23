//
//  ViewModel.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 30/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    // MARK: Public Properties
    
    let disposeBag = DisposeBag()
    let marketSubject = PublishSubject<MarketModel>()
    let selectMarketSubject = PublishSubject<Void>()
    
    var currentUser: CurrentUserModel
    var market: MarketModel? = MarketsModel.shared.markets.first {
        didSet {
            if let market = self.market {
                self.marketSubject.onNext(market)
            }
        }
    }
    
    // MARK: Initialization
    
    init(_ currentUserModel: CurrentUserModel) {
        self.currentUser = currentUserModel
    }
}
