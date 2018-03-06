//
//  ViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import MBProgressHUD

class ViewController<T: ControllerViewModel>: UIViewController {

    // MARK: Public Properties
    
    var disposeBag = DisposeBag()
    var viewModel: T
    
    // MARK: Initialization
    
    init(_ viewModel: T) {
        self.viewModel = viewModel
        
        super.init(nibName: toString(type(of: self)), bundle: .main)
        
        viewModel.logoutSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: viewModel.disposeBag)
        
        viewModel.selectMarketSubject
            .asObservable()
            .subscribe({ [weak self] _ in
                if let currentUser = self?.viewModel.currentUser {
                    let controller = MarketsViewController(MarketsViewModel(user: currentUser)) { [weak self] in
                        MarketsModel.shared.currentMarket = $0
                        
                        self?.viewModel.market = $0
                    }
                    
                    controller.modalPresentationStyle = .overCurrentContext
                    self?.present(controller, animated: true)
                }
            })
            .disposed(by: viewModel.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.market = MarketsModel.shared.currentMarket
    }
    
    // MARK: Public Methods
    
    func check(response: Result<JSON>, with completionHandler: (JSON) -> ()) {
        self.view.hideHUD()
        
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
}
