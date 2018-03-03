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
    
    // MARK: IBOutlets
    
    @IBOutlet var priceTextField: UITextField?
    @IBOutlet var volumeMainTextField: UITextField?
    @IBOutlet var volumeSecondTextField: UITextField?
    
    @IBOutlet var buyButton: UIButton?
    @IBOutlet var sellButton: UIButton?
    @IBOutlet var cancelButton: UIButton?
    
    // MARK: Private Properties
    
    private var disposeBag = DisposeBag()
    private var price: Double = 0
    private var volume: Double = 0
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.priceTextField?
            .rx
            .text
            .skip(1)
            .bind(onNext: { [weak self] in
                self?.parsePrice($0)
            }).disposed(by: self.disposeBag)
        
        self.volumeMainTextField?
            .rx
            .text
            .skip(1)
            .bind(onNext: { [weak self] in
                self?.parseMainVolume($0)
            }).disposed(by: self.disposeBag)
        
        self.volumeSecondTextField?
            .rx
            .text
            .skip(1)
            .bind(onNext: { [weak self] in
                self?.parseSecondVolume($0)
            }).disposed(by: self.disposeBag)
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 44)
        view.backgroundColor = .red
        
        let doneButton = UIButton()
        doneButton.frame = CGRect(x: self.frame.width - 80, y: 7, width: 60, height: 30)
        doneButton.backgroundColor = .green
        doneButton.setTitle("done", for: .normal)
        doneButton.addTarget(self, action: #selector(endEditing(_:)), for: .touchUpInside)
        
        view.addSubview(doneButton)
        doneButton.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
        self.priceTextField?.inputAccessoryView = view
        self.volumeMainTextField?.inputAccessoryView = view
        self.volumeSecondTextField?.inputAccessoryView = view
    }
    
    // MARK: Public Methods
    
    func fill(with viewModel: NewOrderViewModel) {
        self.buyButton?
            .rx
            .tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                viewModel.createOrder(side: .buy,
                                      volume: self?.volume ?? 0,
                                      price: self?.price ?? 0)
            })
            .disposed(by: viewModel.disposeBag)
        
        self.sellButton?
            .rx
            .tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                viewModel.createOrder(side: .sell,
                                      volume: self?.volume ?? 0,
                                      price: self?.price ?? 0)
            })
            .disposed(by: viewModel.disposeBag)
        
        viewModel.order.map { [weak self] in
            let orderViewModel = OrderViewModel($0)
            
            let price = orderViewModel.price
            let volumeMain = orderViewModel.volumeMainCurrency
            let volumeSecond = orderViewModel.volumeSecondCurrency
            
            
            self?.priceTextField?.text = price
            self?.volumeMainTextField?.text = volumeMain
            self?.volumeSecondTextField?.text = volumeSecond
            
            self?.parsePrice(price)
            self?.parseMainVolume(volumeMain)
        }
    }
    
    // MARK: Private Methods
    
    private func parsePrice(_ price: String?) {
        guard let unwrappedPrice = price else { return }
        
        if let priceDouble = Double(unwrappedPrice) {
            self.priceTextField?.textColor = UIColor.black
            self.price = priceDouble
            
            self.volumeSecondTextField?.text = String(format: "%.8f", priceDouble * self.volume)
        } else {
            self.priceTextField?.textColor = UIColor.red
        }
    }
    
    private func parseMainVolume(_ volume: String?) {
        guard let unwrappedVolume = volume else { return }
        
        if let volumeDouble = Double(unwrappedVolume) {
            self.volumeMainTextField?.textColor = UIColor.black
            self.volume = volumeDouble
            
            self.volumeSecondTextField?.text = String(format: "%.8f", self.price * volumeDouble)
        } else {
            self.volumeMainTextField?.textColor = UIColor.red
        }
    }
    
    private func parseSecondVolume(_ volume: String?) {
        guard let unwrappedVolume = volume else { return }
        
        if let volumeDouble = Double(unwrappedVolume) {
            self.volumeSecondTextField?.textColor = UIColor.black
            self.volume = volumeDouble
            
            self.volumeMainTextField?.text = String(format: "%.8f", volumeDouble / self.price)
        } else {
            self.volumeSecondTextField?.textColor = UIColor.red
        }
    }
}
