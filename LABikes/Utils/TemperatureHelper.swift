//
//  TemperatureHelper.swift
//  LABikes
//
//  Created by Matt Deuschle on 12/24/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

class KelvinToFahrenheitConverter {

    var kelvin: Double

    init(kelvin: Double) {
        self.kelvin = kelvin
    }

    func convert() -> String {
        let kelvin = (self.kelvin * (9/5) - 459.67)
        let fahrenheit = Int(round(10 * kelvin/10))
        return "\(fahrenheit)°"
    }
}

