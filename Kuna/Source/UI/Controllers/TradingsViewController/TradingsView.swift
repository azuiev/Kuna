//
//  TradingsView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 03/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

class TradingsView: MainView {
    
    // MARK: Constants
    
    private struct Constants {
        static let tabName = "Tradings"
    }
    
    // IBOutlets
    
    @IBOutlet var buyOrders: UITableView?
    @IBOutlet var sellOrders: UITableView?
    @IBOutlet var segmentedView: UISegmentedControl?
    
    // MARK: Public Properties
    
    override var tabName: String { return Constants.tabName }
    
    let disposeBag = DisposeBag()
    
    // MARK: Private Properties
    
    var timer: Timer?
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _ = self.segmentedView?
            .rx
            .value
            .asObservable()
            .subscribe({ [weak self] in
                let item = $0.element ?? 0
                let view: UITableView?
                switch item {
                    case 0:  view = self?.buyOrders
                    case 1:  view = self?.sellOrders
                default:
                    view = UITableView()
                }
                
                view.map { [weak self] in
                    self?.bodyView?.bringSubview(toFront: $0)
                }
                
                //viewModel.onSwitch(with: $0)
            })
            .disposed(by: self.disposeBag)
        
    }
    
    // MARK: Public Methods
    
    func fill(with viewModel: TradingsViewModel) {
       
    }
    
    func startTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            print("Test")
        }
        
        timer.fire()
        
        self.timer = timer
    }
    
    func stopTimer() {
        self.timer?.invalidate()
    }
}
