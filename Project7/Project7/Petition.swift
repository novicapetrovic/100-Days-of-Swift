//
//  Petition.swift
//  Project7
//
//  Created by Novica Petrovic on 05/03/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
