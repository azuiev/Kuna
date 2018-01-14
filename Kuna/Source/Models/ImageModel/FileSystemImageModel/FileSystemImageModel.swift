//
//  FileSystemImageModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 20/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class FileSystemImageModel: ImageModel {

    // MARK: Public Properties
    
    var fileSystemName: String {
        get {
            return self.imagePath?.appending(self.url.path) ?? ""
        }
    }
    
    /*override init(url: URL) {
        super.init(url: url)
    }*/
    
    // MARK: Public Methods
    
    override func loadImage(with completionBlock: @escaping CompletionBlock) {
        let cacheFileName = self.fileSystemName
        var image: UIImage? = nil
        let error: Error? = nil
     
        if FileManager.default.fileExists(atPath: cacheFileName) {
            image = UIImage(named: cacheFileName)
        }

        if image == nil {
            do {
                try FileManager.default.removeItem(atPath: cacheFileName)
            } catch let error as NSError {
                print("Ahtung. Unable to delete file: \(error)")
            }
        }
       
        completionBlock(image, error)
    }
}
