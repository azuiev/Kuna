//
//  LoginContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class LoginContext: GetContext {
    
    // MARK: Private Properties
    
    override var urlPath: String { return "api/v2/members/me" }
    
    // MARK: Public Methods
    
    override func executeWithResponse() -> JSON? {
        _ = super.executeWithResponse()

        Alamofire.request(self.fullUrl, method: self.httpMethod, parameters: parameters)
            .responseJSON {
                print($0)
        }
        
        return nil
    }
    

}
