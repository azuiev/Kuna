//
//  AlertService.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 13/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class AlertService {
    
    // MARK: Class Methods
    
    static func addAlert(to controller: UIViewController, with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        controller.present(alertController, animated: true)
    }
    
    // MARK: Initialization
    
    private init() {}
    
}
