//
//  MainView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 23/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

class MainView: UIView {

    // MARK: Constants
    
    private struct Constants {
        static let windowName = "Kuna"
        static let tabName = "Main"
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
        self.addSubview(headerView)
        
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let headerHeight = height / 6
        let bodyHeight = height - headerHeight
        let bodyView = self.bodyView
        
        headerView.frame.size.height = headerHeight
        headerView.frame.size.width = width
        
        bodyView?.frame.size.height = bodyHeight
        bodyView?.frame.origin.y = headerHeight
        
        self.headerView = headerView
        self.setupHeaderItems()
        self.setWindowLabelText()
    }
    
    // MARK: Public Methods
    
    func fill<T: ViewModel>(with viewModel: T) {
        self.headerView?.marketTapGestureRecognizer?
            .rx
            .event
            .asObservable()
            .subscribe({ _ in 
                viewModel.marketSubject.onNext(MarketModel())
            })
            .disposed(by: self.disposeBag)
    }
    
    func setupHeaderItems() {
        guard let unwprappedHeaderView = self.headerView else { return }
        
        let imageView = UIImageView(image: UIImage(named: "btc"))
        let imageView2 = UIImageView(image: UIImage(named: "arrow"))
        let imageView3 = UIImageView(image: UIImage(named: "uah"))
        let stackView = UIStackView(arrangedSubviews: [imageView, imageView2, imageView3])
        
        stackView.axis = .horizontal
        stackView.frame.size.height = 33
        stackView.frame.size.width = 100
        stackView.frame.origin.x = unwprappedHeaderView.frame.width - stackView.frame.width - 5
        stackView.frame.origin.y = unwprappedHeaderView.frame.height - stackView.frame.height - 5
        
        stackView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        stackView.addGestureRecognizer(tapGestureRecognizer)
        unwprappedHeaderView.marketTapGestureRecognizer = tapGestureRecognizer
        
        unwprappedHeaderView.addSubview(stackView)
    }
    
    private func setWindowLabelText() {
        self.headerView.map { [weak self] in
            $0.windowNameLabel?.text = self?.windowName
            $0.tabNameLabel?.text = self?.tabName
        }
    }
}
