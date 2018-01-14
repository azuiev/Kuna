//
//  Context.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 31/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

class Context {
    
    // MARK: Public Properties
    
    let model: Model
    
    // MARK: Initialization
    
    init(model: Model) {
        self.model = model
    }
    
    // MARK: Public Methods
    
    func execute() {
        self.execute { _ in
               //self.model.state = $0
            
        }
    }
    
    func execute(withCompletion completionHandler: @escaping (ModelState) -> ()) {
        
    }
    
    func cancel() {
        
    }
}
