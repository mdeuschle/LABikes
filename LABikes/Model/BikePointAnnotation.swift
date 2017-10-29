//
//  BikePointAnnotation.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/1/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation
import MapKit

class BikePointAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var locationName: String
    var discipline: String

    init(title: String, coordinate: CLLocationCoordinate2D, locationName: String, discipline: String) {
        self.title = title
        self.coordinate = coordinate
        self.locationName = locationName
        self.discipline = discipline
    }
}

