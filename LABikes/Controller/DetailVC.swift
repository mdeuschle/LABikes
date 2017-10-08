//
//  DetailVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/8/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var selectedBike: Bike?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let bike = selectedBike {
            title = bike.name
        }
    }

    func didSelectBike(bike: Bike) {
        title = bike.name
    }
}
