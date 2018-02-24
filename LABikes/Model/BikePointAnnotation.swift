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
    var bike: Bike?

    init(bike: Bike) {
        self.bike = bike
        self.coordinate = bike.coordinate2D
        self.title = bike.mapIcon.rawValue
    }
}

