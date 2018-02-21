//
//  MarketViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 21/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Protocol UICollectionViewDataSource

extension MarketsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.backgroundColor = UIColor.yellow
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSize = CGSize(width: 30, height: 30)
        return cellSize
    }
}

// MARK: Protocol UICollectionViewDelegate

extension MarketsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true) { [weak self] in
            self?.presentingController?.viewModel?.market = MarketModel("waves", "uah")
        }
    }
}

// MARK: Protocol ViewViewModel

extension MarketsViewController: ViewViewModel {
    typealias ViewType = MarketsView
    typealias ViewModelType = LoginViewModel
}

class MarketsViewController: ViewController {

    // MARK: Private Properties
    
    private var presentingController: ViewController?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.markets?.backgroundColor = UIColor.red
        self.rootView?.markets?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
    }
    
    // MARK: Initialization
    
    init(_ viewModel: ViewModel, presentingViewController: ViewController?) {
        self.presentingController = presentingViewController
        
        super.init(viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
