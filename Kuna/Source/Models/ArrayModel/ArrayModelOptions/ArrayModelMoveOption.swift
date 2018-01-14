//
//  ArrayModelMoveOption.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 23/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ArrayModelMoveOption: ArrayModelOption {

    // MARK: Public Properties
    
    var sourceIndex: Int
    var destinationIndex: Int
    
     // MARK: Initialization
    
    init(sourceIndex: Int, destinationIndex: Int) {
        self.sourceIndex = sourceIndex
        self.destinationIndex = destinationIndex
        
        super.init()
    }
    
    // MARK: Override Methods
    
    override func applyChanges(to tableView: UITableView,
                               with animation: UITableViewRowAnimation = UITableViewRowAnimation.automatic,
                               in section: Int = 0)
    {
        let sourceIndexPath = self.indexPath(with: self.sourceIndex, in: section)
        let destinationIndexPath = self.indexPath(with: self.destinationIndex, in: section)
        
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
    
}
