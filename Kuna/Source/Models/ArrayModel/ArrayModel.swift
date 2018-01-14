//
//  ArrayModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ArrayModel<T: Equatable>: Model {
    
    // MARK: Public Properties
    
    var array: Array<T>
    
    var count: Int {
        return synchronized(lockObject: self) {
            return self.array.count
        }
    }
    
    // MARK: Initialization
    
    init(array: Array<T>) {
        self.array = array
        
        super.init()
    }
    
    // MARK: Public Methods
    
    func add(object: T) {
        self.insert(object: object, at: self.count)
    }
    
    func remove(object: T) {
        self.removeObject(at: self.array.index(of: object))
    }
    
    func add(objects: [T]) {
        objects.forEach {
            self.add(object: $0)
        }
    }
    
    func remove(objects: [T]) {
        objects.forEach {
            self.remove(object: $0)
        }
    }

    func object(at index: Int) -> T? {
        return self.count > index ? self.array[index] : nil
    }
    
    func set(object: T?, at index: Int) {
        synchronized(lockObject: self) {
            guard let item = object, self.count > index else { return }
            
            self.array[index] = item
            
            //[self notifyWithObject:[AZArrayModelChange arrayModelRemoveChangeWithIndex:index]];
        }
    }

    func moveRow(from sourceIndex: Int, to destinationIndex: Int) {
        synchronized(lockObject: self) {
            if sourceIndex != destinationIndex {
                
                let object = self.object(at: sourceIndex)
                self.removeObject(at: sourceIndex)
                self.insert(object: object, at: destinationIndex)
                
                //[self notifyWithObject:[AZArrayModelChange arrayModelMoveChangeFromIndex:sourceIndex toIndex:destinationIndex]];
            }
        }
    }
    
    func first() -> T? {
        return self.array.first
    }
    
    // MARK: Subscripts
    
    subscript(index: Int) -> T? {
        get {
            return self.object(at: index)
        }
        set {
            self.set(object: newValue, at: index)
        }
    }
    
    // MARK: Private Methods
    
    private func insert(object: T?, at index: Int) {
        synchronized(lockObject: self) {
            guard let item = object, self.count >= index else { return }
            
            self.array.insert(item, at: index)
            
            // [self notifyWithObject:[AZArrayModelChange arrayModelAddChangeWithIndex:index]];
        }
    }
    
    private func removeObject(at index: Int?) {
        synchronized(lockObject: self) {
            guard let number = index, self.count > number else { return }
            
            self.array.remove(at: number)
            //self.set(state: .didChange, with: ArrayModelOption.removeOption(with: number))
        }
    }
 }

