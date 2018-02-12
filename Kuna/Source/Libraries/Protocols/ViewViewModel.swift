//
//  ViewViewModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 12/02/2018.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

protocol ViewViewModel {
    associatedtype ViewType: UIView
    associatedtype ViewModelType: ViewModel
    
    var rootView: ViewType? { get }
    var mainViewModel: ViewModelType { get }
}

extension ViewViewModel where Self: ViewController {
    var rootView: ViewType? {
        return self.viewIfLoaded as? ViewType
    }
    
    var mainViewModel: ViewModelType {
        guard let result = self.viewModel as? ViewModelType else {
            fatalError()
        }
        
        return result
    }
}


