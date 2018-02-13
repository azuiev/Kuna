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
    
    func showAlert(with description: String) {
        AlertService.addAlert(to: self, with: description)
    }
}
