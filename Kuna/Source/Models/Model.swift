//
//  Model.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 25/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

protocol Save {
    func save()
}

class Model {
    
    // MARK: Public methods
    
    /*
     func load() {
     synchronized(lockObject: self) { [weak self] in
     let state = self?.state;
     if .didLoad == state {
     self?.state = .didLoad
     
     return
     }
     
     self?.state = .willLoad
     }
     
     self.loadObject()
     }
     */
    
    func loadObject() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.performLoading()
        }
    }
    
    func performLoading() {
        
    }
}
