//
//  InternetImageModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 20/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class InternetImageModel: FileSystemImageModel {

    // MARK: Public Properties
    
    var downloadTask: URLSessionDownloadTask? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    // MARK: Initialization
    /*
    override init(url: URL) {
        super.init(url: url)
    }*/
    
    // MARK: Public Methods
    
    override func cancel() {
        if let task = self.downloadTask {
            switch task.state {
            case .running, .suspended:
                task.cancel()
            default:
                self.image = nil
            }
        }
    }

    override func loadImage(with completionBlock: @escaping CompletionBlock) {
        super.loadImage() { image, error in
            if image != nil {
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                    //self?.state = .didLoad
                }
            } else {
                let session = URLSession.shared
                var newImage: UIImage? = nil
                var task = self.downloadTask
                if task == nil {
                    task = session.downloadTask(with: self.url) { (location, response, error) in
                        self.saveTemporaryFile(with: location)
                        
                        do {
                            newImage = try UIImage(data: Data(contentsOf: self.fileSystemUrl()))
                        } catch let error as NSError {
                            print("Achtung. Unable to get data from url \(error)")
                        }
                        
                        completionBlock(newImage, error)
                    }
                    
                     self.downloadTask = task
                }
                
                task?.resume()
            }
        }
    }
    
    // MARK : Private Methods
    
    private func saveTemporaryFile(with url: URL?) {
        
        let destinationUrl = self.fileSystemUrl()
        let saved = FileManager.default.moveItem(from: url, to: destinationUrl)
        if !saved {
            print("Failed to save \(String(describing: url)) to \(destinationUrl)")
        }
    }
    
    private func fileSystemUrl() -> URL {
        return URL(fileURLWithPath: self.fileSystemName)
    }
}
