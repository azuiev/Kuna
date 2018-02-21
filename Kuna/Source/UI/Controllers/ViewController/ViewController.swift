//
//  ViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    // MARK: Public Properties
    
    var viewModel: ViewModel?
    
    init(_ viewModel: ViewModel) {
        super.init(nibName: toString(type(of: self)), bundle: .main)
        
        viewModel.marketSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                if let currentUser = self?.viewModel?.currentUser {
                    let controller = MarketsViewController(LoginViewModel(currentUser), presentingViewController: self)
                        controller.modalPresentationStyle = .overCurrentContext
                    self?.present(controller, animated: true, completion: nil)
                }
            })
            .disposed(by: viewModel.disposeBag)
        
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Public Methods
    
    func check(response: Result<JSON>, with completionHandler: (JSON) -> ()) {
        let result = response.map {
            completionHandler($0)
        }
        
        if case Result.Failure(let error) = result {
            self.showAlert(with: error.localizedDescription)
        }
    }
    
    func check(response: Result<JSONArray>, with completionHandler: (JSONArray) -> ()) {
        let result = response.map {
            completionHandler($0)
        }
        
        if case Result.Failure(let error) = result {
            self.showAlert(with: error.localizedDescription)
        }
    }
    
    func showAlert(with description: String) {
        AlertService.addAlert(to: self, with: description)
    }
    
    func selectMarket() {
        AlertService.addAlert(to: self, with: "ADD MARKET")
    }
}
