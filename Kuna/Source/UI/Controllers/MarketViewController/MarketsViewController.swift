//
//  MarketViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 21/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Protocol ViewViewModel

extension MarketsViewController: RootView {
    typealias ViewType = MarketsView
}

class MarketsViewController: ViewController<MarketsViewModel>, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: Protocol UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.completion(self.markets[indexPath.row])
        self.dismiss(animated: true)
    }
    
    // MARK: Protocol UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.markets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketCell", for: indexPath)
        if let marketCell = cell as? MarketCell {
            marketCell.market = self.markets[indexPath.row]
            marketCell.backgroundColor = UIColor.lightGray
            
            return marketCell
        }
        
        return cell
    }
    
    // MARK: Public Properties
    
    var market: MarketModel?
    var completion: (MarketModel) -> ()?
    
    // MARK: Private Properties
    
    var markets: [MarketModel]
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rootView?.cancelButton?
            .rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: self.viewModel.disposeBag)
        
        let nib = UINib(nibName: toString(MarketCell.self), bundle: .main)
        self.rootView?.collectionView?.register(nib, forCellWithReuseIdentifier: "MarketCell")
    }
    
    init(_ viewModel: MarketsViewModel, completion: @escaping (MarketModel) -> ()) {
        self.completion = completion
        self.markets = MarketsModel.shared.markets
        
        super.init(viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
