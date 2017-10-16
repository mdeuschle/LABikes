//
//  Constants.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

typealias BikeHandler = (Bool, [[String: Any]]?) -> Void
let URL_STRING = "https://bikeshare.metro.net/stations/json/"

enum NibName: String {
    case rootVC = "RootVC"
}

enum ReusableCell: String {
    case bike = "BikeCell"
    case map = "MapCell"
}




