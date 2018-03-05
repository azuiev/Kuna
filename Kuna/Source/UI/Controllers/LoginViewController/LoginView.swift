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

    // MARK: Protocol UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    // MARK: IBOutlets
    
    @IBOutlet var loginButton: UIButton?
    @IBOutlet var publicKeyTextField: UITextField?
    @IBOutlet var secretKeyTextField: UITextField?
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer?
    @IBOutlet var fillButton: UIButton?

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
        
        self.fillButton?
            .rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.fillAccessFields()
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Public Methods
    
    func fill(with viewModel:LoginViewModel) {
        self.loginButton?
            .rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.showHUD(mode: .indeterminate, text: "Please wait...")
                viewModel.onLogin(with: AccessTokenModel(publicKey: self?.publicKeyTextField?.text,
                                                         secretKey: self?.secretKeyTextField?.text))
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Private Methods
    
    func fillAccessFields() {
        
        //FullToken
        self.publicKeyTextField?.text = "xVI2OYUtfNWaFQi6ywAx6qyYhS5fOlfzHtCBjfex"
        self.secretKeyTextField?.text = "hTx5aoDot1N0a0LoRkzAzk12jjsQSERG7l7FMIu4"
    }
}
