//
//  JsonLoading.swift
//  Kuna
//
//  Created by Aleksey Zuiev on 06/03/2018.
//  Copyright © 2018 Aleksey Zuiev. All rights reserved.
//

import Foundation

protocol JsonProperty {
    static func loadProperty() -> [Self]
}
