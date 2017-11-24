//
//  ReusableIdentifier.swift
//  LABikes
//
//  Created by Matt Deuschle on 11/23/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

protocol ReusableIdentifier: class {
    static var reusableIdentifier: String { get }
}

extension ReusableIdentifier {
    static var reusableIdentifier: String {
        return "\(self)"
    }
}








