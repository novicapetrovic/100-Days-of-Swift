//
//  Image.swift
//  Milestone Projects 10-12
//
//  Created by Novica Petrovic on 12/03/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import Foundation

class Image: NSObject {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
