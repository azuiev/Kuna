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

    func check(result: Result<JSON>, with completionHandler: (JSON) -> ()) {
        if result.isFailure() {
            _ = result.map {
                print($0)
            }
        } else {
            _ = result.map {
               completionHandler($0)
            }
        }
    }
    
    func parse(json: JSON) {

    }
}
