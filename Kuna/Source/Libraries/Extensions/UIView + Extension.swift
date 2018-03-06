//
//  UIView + Extension.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 26/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation
import MBProgressHUD

extension UIView {
    func showHUD(animated: Bool = true, mode: MBProgressHUDMode = .indeterminate, text: String = "") {
        let hud = MBProgressHUD.showAdded(to: self, animated: animated)
        hud.mode = mode
        hud.label.text = text
    }
    
    func hideHUD(animated: Bool = true) {
        MBProgressHUD.hide(for: self, animated: animated)
    }
}
