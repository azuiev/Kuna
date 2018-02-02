//
//  ImageModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 18/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: Protocol Hashable

extension Hashable where Self: ImageModel {
    var hashValue: Int {
        return self.url.hashValue
    }
}

@objcMembers class ImageModel: Object {
    
    // MARK: Constants
    
    private struct Constants {
        static let URLKey         = "URL"
        static let ImageDirectory = "/Images/"
        static let LoadImageDelay = 0.5
    }
    
    typealias CompletionBlock = (UIImage?, Error?) -> ()

    // MARK: Public properties
    
    var image: UIImage? = nil
    dynamic var stringURL: String = ""
    
    var url: URL = URL.init(fileURLWithPath: "") {
        willSet {
            self.stringURL = newValue.absoluteString
        }
    }
    
    var imagePath: String? {
        get {
            let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            
            return documentPath?.appending(Constants.ImageDirectory)
        }
    }
    
    // MARK: Initialization
    
    static func model(with url: URL) -> ImageModel? {
        /*let cache = ImageModelCache.shared
        var model = cache.object(with: url)
        
        if model == nil {
         */
        let imageType = url.isFileURL ? FileSystemImageModel.self : InternetImageModel.self
           let model = imageType.init()
            //let model = imageType.init(url: URL)
            //cache.set(object: model, for: url)
        
        return model
    }
 
    convenience init(url: URL) {
        self.init()
        
        self.url = url
    }
    
    
    //MARK: Override Methods
    
    override static func ignoredProperties() -> [String] {
        return ["image", "url", "downloadTask"]
    }
    
    func performLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.LoadImageDelay) { [weak self] in
            self?.loadImage { (image, error) in
                DispatchQueue.main.async {
                    self?.image = image
                    //self?.state = image != nil ? .didLoad : .didFailLoading
                }
            }
        }
    }

    // MARK: Public Methods
    
    func loadImage(with completionBlock: @escaping CompletionBlock) {
        
    }
    
    func cancel() {
        
    }
}
