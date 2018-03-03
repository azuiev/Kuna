//
//  UITableView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

extension UITableView {

    func reusableCell<T: UITableViewCell>(with cls: T.Type, indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: toString(cls), for: indexPath)
        
        guard let result = cell as? T else {
            fatalError("Unable to get cell with type \(T.self)")
        }
        
        return result
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableFooterView = UIView(frame: .zero)
    }
}
