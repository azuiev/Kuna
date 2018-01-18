//
//  LoginViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 14/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {

    // MARK: Public Properties
    
    var viewModel: LoginViewModel
    
    var rootView: LoginView? {
        return self.viewIfLoaded as? LoginView
    }
    
    // MARK: Initialization
    
    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: toString(type(of: self)), bundle: .main)
        
        self.viewModel.loginResult
            .asObservable()
            .subscribe({
                _ = $0.map { [weak self] in
                    self?.finishLogging(with:$0)
                }
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        self.rootView?.fill(with: self.viewModel)
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        let view = self.rootView
        
        view?.secretKeyTextField?.becomeFirstResponder()
        view?.publicKeyTextField?.becomeFirstResponder()
    }
    */
    
    // MARK: Private Methods
    
    private func finishLogging(with result: Result<Model>) {
        print("\(result)")
    }
}
