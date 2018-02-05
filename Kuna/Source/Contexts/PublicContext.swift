//
//  PublicContext.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 05/02/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import UIKit
import Alamofire

class PublicContext: Context {

    // MARK: Public Properties
    
    var httpMethod: HTTPMethod { return .get }
    var graphPath: String { return "" }
    var parameters: [String : String] = [:]
    var tonce = { return 12345678 }
    var url = "https://kuna.io/"
    var urlPath: String { return "" }
    var fullUrl: String { return self.url + self.urlPath }
    
    // MARK: Public Methods
    
    func execute(with completionHandler: @escaping (Result<JSON>) -> ()) {

    }
}
