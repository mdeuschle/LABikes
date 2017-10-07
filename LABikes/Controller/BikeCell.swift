//
//  BikeCell.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class BikeCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var bikeAvailableLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    func configCell(bike: Bike) {
        nameLabel.text = bike.name
        addressLabel.text = bike.addressStreet
        bikeAvailableLabel.text = bike.bikesAvailable.bikesString()
        let miles = bike.distance * 0.000621371
        let bikeMiles = Double(round(10 * miles)/10)
        distanceLabel.text = "\(bikeMiles) mi"
    }
}


