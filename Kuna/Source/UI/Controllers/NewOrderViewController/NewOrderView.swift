//
//  NewOrderView
//  Kuna
//
//  Created by Aleksey Zuiev on 23/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewOrderView: UIView, UITextFieldDelegate {

    // MARK: Protocol UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    // IBOutlets
    
    @IBOutlet var priceTextField: UITextField?
    @IBOutlet var mainCurrencyVolumeTextField: UITextField?
    @IBOutlet var secondCurrencyVolumeTextField: UITextField?
    
    @IBOutlet var buyButton: UIButton?
    @IBOutlet var sellButton: UIButton?
    @IBOutlet var cancelButton: UIButton?
    
    // MARK: Public Methods
    
    func fill(with viewModel: OrderViewModel) {
        
    }
}
