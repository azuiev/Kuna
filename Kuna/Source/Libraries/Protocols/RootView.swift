//
//  RootView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 28/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

protocol RootView {
    associatedtype ViewType
    
    var rootView: ViewType? { get }
}

extension RootView where Self: UIViewController {
    var rootView: ViewType? {
        return self.viewIfLoaded as? ViewType
    }
}


