//
//  BikeFetchContract.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/24/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation
import CoreLocation

protocol FetchBikeDataServiceContract {
    func fetchBikeData(currentLocation: CLLocation)
}



