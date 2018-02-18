//
//  TradingsView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 03/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

enum TableType: Int {
    case buyTable       = 0
    case sellTable      = 1
    case tradingsTable  = 2
}

class TradingsView: MainView {
    
    // MARK: Constants
    
    private struct Constants {
        static let tabName = "Tradings"
    }
    
    // IBOutlets
    
    @IBOutlet var buyOrders: UITableView?
    @IBOutlet var sellOrders: UITableView?
    @IBOutlet var tradings: UITableView?
    @IBOutlet var segmentedView: UISegmentedControl?
    
    // MARK: Public Properties
    
    override var tabName: String { return Constants.tabName }
    
    let disposeBag = DisposeBag()
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupHeader()
    }

    // MARK: Public Methods
    
    func fill(with viewModel: TradingsViewModel) {
        self.segmentedView?
            .rx
            .value
            .asObservable()
            .subscribe({[weak self] in
                guard let tableType = TableType(rawValue: $0.element ?? 0) else { return }
                viewModel.onSelectSegment(with: tableType)
                
                let view: UITableView?
                
                switch tableType {
                case .buyTable: view = self?.buyOrders
                case .sellTable: view = self?.sellOrders
                case .tradingsTable: view = self?.tradings
                }
                
                view.map { [weak self] in
                    self?.bodyView?.bringSubview(toFront: $0)
                }
            })
            .disposed(by: self.disposeBag)
        
        viewModel.buyOrdersSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.buyOrders?.reloadData()
            })
                
            .disposed(by: self.disposeBag)
        
        viewModel.sellOrdersSubject
            .asObservable()
            .subscribe({ [weak self] _ in
               self?.sellOrders?.reloadData()
            })
            .disposed(by: self.disposeBag)
        
        viewModel.tradingsSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.tradings?.reloadData()
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Private Methods
    
    private func setupHeader() {
        guard let unwprappedHeaderView = self.headerView else { return }
        
        let imageView = UIImageView(image: UIImage(named: "btc"))
        let imageView2 = UIImageView(image: UIImage(named: "btc"))
        let imageView3 = UIImageView(image: UIImage(named: "uah"))
        let stackView = UIStackView(arrangedSubviews: [imageView, imageView2, imageView3])

        stackView.axis = .horizontal
        stackView.frame.size.height = 33
        stackView.frame.size.width = 100
        stackView.frame.origin.x = unwprappedHeaderView.frame.width - stackView.frame.width
        stackView.frame.origin.y = unwprappedHeaderView.frame.height - stackView.frame.height
        
        stackView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        
        unwprappedHeaderView.addSubview(stackView)
    }
}
