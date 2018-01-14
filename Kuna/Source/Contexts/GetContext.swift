//
//  GetContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class GetContext: Context {
    
    // MARK: Public Properties
    
    var graphPath: String { return "" }
    var parameters: [String : String] { return [:] }
    var currentUser: Model
    
    // MARK: Initialization
    
    init(model: Model, currentUser: Model) {
        self.currentUser = currentUser
        
        super.init(model: model)
    }
    
    // MARK: Public Methods
    
    func token() -> String? {
        return ""
    }
    
    func finishLoading(with response: [String : Any]) {
        
    }

    // MARK: Override Methods
    
    override func execute(withCompletion completionHandler: @escaping(ModelState) -> Void) {

    }
    
    // MARK: Private methods
    
    func save(response : JSON) {
        NSKeyedArchiver.archiveRootObject(response, toFile: self.fileName())
    }
    
    func loadSavedResponse() -> [String : Any]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: self.fileName()) as? [String : Any]
    }
    
    func fileName() -> String {
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
            return path.appending("/").appending(self.graphPath)
        } else {
            return ""
        }
    }
}

