//
//  ArrayModelRemoveOption.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 23/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ArrayModelRemoveOption: ArrayModelOption {

    // MARK: Public Properties
    
    var index: Int
    
    // MARK: Initialization
    
    init(index: Int) {
        self.index = index
        
        super.init()
    }
    
    // MARK: Override Methods
    
    override func applyChanges(to tableView: UITableView,
                               with animation: UITableViewRowAnimation = UITableViewRowAnimation.automatic,
                               in section: Int = 0)
    {
        let indexPath = self.indexPath(with: self.index, in: section)
        
        tableView.deleteRows(at: [indexPath], with: animation)
    }
}
