//
//  BikeCell.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/28/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class BikeCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var numberOfBikesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    func config(bike: Bike) {
        self.nameLabel.text = bike.name
        self.addressLabel.text = bike.addressStreet
        self.numberOfBikesLabel.text = bike.bikesAvailable.bikeIntToString()
        self.distanceLabel.text = bike.miles
    }
}
