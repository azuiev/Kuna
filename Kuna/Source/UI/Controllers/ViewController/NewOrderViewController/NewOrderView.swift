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
    @IBOutlet var mainCurrencyVolumeTextField: UITextField?
    @IBOutlet var secondCurrencyVolumeTextField: UITextField?
    
    @IBOutlet var buyButton: UIButton?
    @IBOutlet var sellButton: UIButton?
    @IBOutlet var cancelButton: UIButton?
    
    // MARK: Private Properties
    
    private var disposeBag = DisposeBag()
    private var price: String = ""
    private var volume: String = ""
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.mainCurrencyVolumeTextField?
            .rx
            .controlEvent([.editingDidEnd])
            .subscribe(onNext: {
                print("TEST")
            })
            .disposed(by: self.disposeBag)
    }
    // MARK: Public Methods
    
    func fill(with viewModel: NewOrderViewModel) {
        viewModel.order.map { [weak self] in
            let orderViewModel = OrderViewModel($0)
            
            self?.priceTextField?.text = orderViewModel.price
            self?.mainCurrencyVolumeTextField?.text = orderViewModel.volumeMainCurrency
            self?.secondCurrencyVolumeTextField?.text = orderViewModel.volumeSecondCurrency
        }
        
        self.buyButton?
        .rx
        .tap
        .asObservable()
            .subscribe({ [weak self] _ in
                viewModel.createOrder(side: .buy,
                                      volume: self?.volume ?? "",
                                      price: self?.priceTextField?.text ?? "")
            })
            .disposed(by: viewModel.disposeBag)
        
        self.sellButton?
            .rx
            .tap
            .asObservable()
            .subscribe({ [weak self] _ in
                viewModel.createOrder(side: .sell,
                                      volume: self?.mainCurrencyVolumeTextField?.text ?? "",
                                      price: self?.priceTextField?.text ?? "")
            })
            .disposed(by: viewModel.disposeBag)
    }
}
