//
//  FileManager+Extension.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 20/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

extension FileManager {
    
    typealias OperationBlock = (URL?, URL?) -> Bool
    
    func moveItem(from sourceUrl: URL?, to destinationUrl: URL?) -> Bool {
        return self.performOperation(with: sourceUrl, destinationUrl: destinationUrl) { url1, url2 in
            var result = true
            do {
                try self.moveItem(at: url1!, to: url2!)
            } catch let error {
                result = false
                print ("Unable to perform operation \(error)")
            }
            
            return result
        }
    }
    
    // MARL: Private Methods
    
    private func performOperation(with sourceUrl: URL?, destinationUrl: URL?, operation: OperationBlock) -> Bool {
        guard self.checkSource(url: sourceUrl) && self.checkdestination(url: destinationUrl) else { return false }
        
        return operation(sourceUrl, destinationUrl)
    }
    
    private func checkSource(url: URL?) -> Bool {
        guard let checkedUrl = url else { return false }
        let filePath = checkedUrl.path
        if !self.fileExists(atPath: filePath) {
            print("File not found at \(filePath)")
            
            return false
        }
        
        return true
    }
    
    private func checkdestination(url: URL?) -> Bool {
        guard let checkedUrl = url, checkedUrl.isFileURL else { return false }
        let path = checkedUrl.deletingLastPathComponent().path
        
        if !self.fileExists(atPath: path) {
            do {
                try self.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print ("Achtung. Unable to create directory \(error)")
                
                return false
            }
        }
        
        return true
    }
}
