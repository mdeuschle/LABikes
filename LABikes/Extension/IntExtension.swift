//
//  IntExtension.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/1/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

extension Int {
    func bikesString() -> String {
        return self == 1 ? "\(self) bike available" : "\(self) bikes avilable"
    }
}








