//
//  Capital.swift
//  Project16
//
//  Created by Novica Petrovic on 13/03/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
