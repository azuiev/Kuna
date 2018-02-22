//
//  ViewViewModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 12/02/2018.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

protocol RootView {
    associatedtype ViewType: UIView
    
    var rootView: ViewType? { get }
}

extension RootView where Self: UIViewController {
    var rootView: ViewType? {
        return self.viewIfLoaded as? ViewType
    }
}


