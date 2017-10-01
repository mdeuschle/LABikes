//
//  Constants.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

typealias BikeHandler = (Bool, [Bike]?) -> Void
let URL_STRING = "https://github.com/mdeuschle/LABikes/blob/development/LABikes/Model/Bike.swift"

enum NibName: String {
    case rootVC = "RootVC"
}

enum ReusalbleCell: String {
    case bike = "BikeCell"
}




