//
//  Person.swift
//  Project10
//
//  Created by Novica Petrovic on 07/03/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
