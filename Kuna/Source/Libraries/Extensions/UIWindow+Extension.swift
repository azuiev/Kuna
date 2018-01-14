//
//  UIWindow+Extension.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 07/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

extension UIWindow {
    func perform(block: (UIWindow) -> ()) {
        block(self)
        
        self.makeKeyAndVisible()
    }
}
