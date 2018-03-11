//
//  MainView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 23/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

class MainView: UIView, TableView {
    
    // MARK: Prtotcol TableView
    
    var tableView: [UITableView] {
        return []
    }
    
    // MARK: Constants
    
    private struct Constants {
        static let windowName                   = "Kuna"
        static let tabName                      = "Main"
        static let marketWidth                  = 100
        static let marketHeight                 = 33
        static let headerMultiplier: CGFloat    = 6
        static let viewVerticalGap: CGFloat     = 5
        static let viewHorizontalGap: CGFloat   = 5
    }
    
    // MARK: IBOutlets
    
    @IBOutlet var bodyView: UIView?
    
    // MARK: Public Properties
    
    let disposeBag = DisposeBag()
    var tabName: String { return Constants.tabName }
    
    // MARK: Private Properties
    
    private var windowName: String { return Constants.windowName }
    var headerView: HeaderView?
    
    // MARK: UI Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let headerView = UINib.object(with: HeaderView.self, bundle: .main)
        
        let width, height: CGFloat
        
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            width = UIScreen.main.bounds.height
            height = UIScreen.main.bounds.width
        default:
            height = UIScreen.main.bounds.height
            width = UIScreen.main.bounds.width
        }
        
        let headerHeight = height / Constants.headerMultiplier
        
        headerView.frame.size.height = headerHeight
        headerView.frame.size.width = width
        
        self.headerView = headerView
        self.addSubview(headerView)
        self.setupConstraints()
        self.setupHeaderItems()
        self.setWindowLabelText()
    }
    
    // MARK: Public Methods
    
    func fill(with viewModel: ControllerViewModel) {
        let header = self.headerView
        header?.marketView?.market = viewModel.market
        
        header?.marketTapGestureRecognizer?
            .rx
            .event
            .asObservable()
            .subscribe({ _ in 
                viewModel.selectMarketSubject.onNext(())
            })
            .disposed(by: self.disposeBag)
        
        header?.exitButton?
            .rx
            .tap
            .asObservable()
            .subscribe({ _ in
                viewModel.logout()
            })
            .disposed(by: self.disposeBag)
        
        viewModel.hudSubject
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.displayHud($0)
            })
            .disposed(by: self.disposeBag)
        
        viewModel.marketSubject
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.headerView?.marketView?.market = $0
            })
            .disposed(by: self.disposeBag)
    }
    
    func setupHeaderItems() {
        guard let headerView = self.headerView else { return }
        
        let marketView = UINib.object(with: MarketView.self, bundle: .main)
        let size = CGSize(width: Constants.marketWidth, height: Constants.marketHeight)
        let origin = CGPoint(x: headerView.frame.width - size.width - Constants.viewHorizontalGap,
                             y: headerView.frame.height - size.height - Constants.viewHorizontalGap)
        
        marketView.frame = CGRect(origin: origin, size: size)
        marketView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        marketView.addGestureRecognizer(tapGestureRecognizer)
        
        headerView.marketTapGestureRecognizer = tapGestureRecognizer
        headerView.addSubview(marketView)
        headerView.marketView = marketView
    }
    
    func displayHud(_ flag: Bool) {
        for view in tableView {
            flag ? view.showHUD(text: "Loading...") : view.hideHUD()
        }
    }
    
    // MARK: Private Methods
    
    private func setupConstraints() {
        if let bodyView = self.bodyView {
            
            bodyView.translatesAutoresizingMaskIntoConstraints = false
            
            if let bottomAnchor = self.headerView?.bottomAnchor {
                bodyView.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
            }
            
            NSLayoutConstraint.activate([
                bodyView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                bodyView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                bodyView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
                ])
        }
    }
    
    private func setWindowLabelText() {
        self.headerView.map { [weak self] in
            $0.windowNameLabel?.text = self?.windowName
            $0.tabNameLabel?.text = self?.tabName
        }
    }
}
