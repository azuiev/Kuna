//
//  ImageModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 18/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ImageModel: Model {
    
    // MARK: Constants
    
    private struct Constants {
        static let URLKey         = "URL"
        static let ImageDirectory = "/Images/"
        static let LoadImageDelay = 0.5
    }
    
    typealias CompletionBlock = (UIImage?, Error?) -> ()

    
    // MARK: Protocol Hashable
    
    public var hashValue: Int {
        return self.url.hashValue
    }
    
    // MARK: Public properties
    
    var image: UIImage?
    var imagePath: String? {
        get {
            let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            
            return documentPath?.appending(Constants.ImageDirectory)
        }
    }
    
    var url: URL
    
    // MARK: Initialization
    
    static func model(with url: URL) -> ImageModel? {
        /*let cache = ImageModelCache.shared
        var model = cache.object(with: url)
        
        if model == nil {
         */
        let imageType = url.isFileURL ? FileSystemImageModel.self : InternetImageModel.self
           let model = imageType.init(url: url)
            //cache.set(object: model, for: url)
        
        
        return model
    }
    
    required init(url: URL) {
        self.url = url
        super.init()
    }
    
    //MARK: Override Methods
    
    override func performLoading() {
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
