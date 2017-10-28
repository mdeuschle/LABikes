//
//  CurrentLocation.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/22/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocation {
    var location = CLLocation(latitude: 34.0201613, longitude: -118.6919205)
    func myLocation(_ currentLocation: CLLocation) {
        location = currentLocation
    }
}
