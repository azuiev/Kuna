//
//  BalancesViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 21/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class BalancesViewController: UIViewController {

    // MARK: Public Properties
    
    var viewModel: LoginViewModel
    
    var rootView: BalancesView? {
        return self.viewIfLoaded as? BalancesView
    }
    
    // MARK: Initialization
    
    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel

        super.init(nibName: toString(type(of: self)), bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        self.rootView?.fill(with: self.viewModel)
    }
    
    // MARK: Private Methods
    
    private func finishLogging(with result: Result<JSON>) {
        print("\(result)")

    }
}
