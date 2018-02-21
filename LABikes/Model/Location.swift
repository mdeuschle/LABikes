//
//  Location.swift
//  LABikes
//
//  Created by Matt Deuschle on 12/18/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import CoreLocation

class Location {

    static let shared = Location()
    private init() {}
    var location: CLLocation?
}


