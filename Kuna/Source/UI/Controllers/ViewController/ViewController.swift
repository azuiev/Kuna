//
//  ViewController.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Public Methods
    // TODO ADD COMPLITION
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
