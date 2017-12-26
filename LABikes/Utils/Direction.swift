//
//  Direction.swift
//  LABikes
//
//  Created by Matt Deuschle on 12/25/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

struct Direction {

    private var lat: Double
    private var lon: Double

    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }

    func openMaps() {
        guard let url = URL(string: "http://maps.apple.com/maps?daddr=\(String(lat)),\(String(lon))") else {
            return
        }
        UIApplication.shared.open(url, options: [String : Any](), completionHandler: nil)
    }
}


