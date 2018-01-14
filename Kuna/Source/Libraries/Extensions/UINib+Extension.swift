//
//  UINib+Extension.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 09/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

extension UINib {
    
    static func nib<T>(with type: T.Type, bundle: Bundle? = nil) -> UINib? {
        return UINib.init(nibName: String(describing: type), bundle: bundle)
    }
    
    static func object<T>(with type: T.Type, bundle: Bundle? = nil, owner: Any? = nil, options: [AnyHashable : Any]? = nil) -> T? {
        let nib = self.nib(with: type, bundle: bundle)
        if nib != nil {
            return nib?.object(with: type, owner: owner, options: options)
        }
        
        return nil
    }
    
    func object<T>(with type: T.Type, owner: Any? = nil, options: [AnyHashable : Any]?) -> T? {
        let objects = self.instantiate(withOwner: owner, options: options)
        
        return objects.first as? T
    }
}
