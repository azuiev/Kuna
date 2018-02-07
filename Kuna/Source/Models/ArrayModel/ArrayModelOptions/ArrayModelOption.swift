//
//  ArrayModelOption.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 23/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ArrayModelOption {
    
    // MARK: Initialization
    
    static func removeOption(with index: Int) -> ArrayModelRemoveOption {
        return ArrayModelRemoveOption(index: index)
    }
    
    static func addOption(with index: Int) -> ArrayModelAddOption {
        return ArrayModelAddOption(index: index)
    }
    
    static func moveOption(with sourceIndex: Int, destinationIndex: Int) -> ArrayModelMoveOption {
        return ArrayModelMoveOption(sourceIndex: sourceIndex, destinationIndex: destinationIndex)
    }
    
    // MARK: Public Methods
    
    func indexPath(with index: Int, in section: Int) -> IndexPath {
        return IndexPath.init(row: index, section: section)
    }
    
    func applyChanges(to tableView: UITableView, with animation: UITableViewRowAnimation = UITableViewRowAnimation.automatic, in section: Int = 0) {
    }
}
