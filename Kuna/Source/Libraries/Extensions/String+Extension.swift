//
//  String+Extension.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 29/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

extension String {
    func asURL() -> URL? {
        _ = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .map { return URL(fileURLWithPath: $0) }
        return nil
    }
}
