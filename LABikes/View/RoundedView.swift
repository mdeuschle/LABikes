//
//  RoundedView.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
    }
}
