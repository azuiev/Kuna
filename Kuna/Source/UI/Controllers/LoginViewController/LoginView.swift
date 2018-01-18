//
//  LoginView.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 18/01/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginView: UIView, UITextFieldDelegate {

    // MARK: IBOutlets
    
    @IBOutlet var loginButton: UIButton?
    @IBOutlet var secretKeyTextField: UITextField?
    @IBOutlet var publicKeyTextField: UITextField?
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer?
    
    // MARK: Public Properties
    
    let disposeBag = DisposeBag()
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tapGestureRecognizer?
            .rx
            .event
            .asObservable()
            .subscribe(
                onNext: { [weak self] _ in
                    self?.endEditing(true)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Public Methods
    
    func fill(with viewModel:LoginViewModel) {
        self.loginButton?
            .rx
            .tap
            .subscribe(onNext: {
                viewModel.onLogin()
            })
            .disposed(by: self.disposeBag)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
