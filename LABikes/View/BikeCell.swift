//
//  BikeCell.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/28/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class BikeCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var numberOfBikesLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    private var bike: Bike?

    func config(bike: Bike) {
        self.nameLabel.text = bike.name
        self.numberOfBikesLabel.text = bike.bikesAvailable.bikeIntToString()
        self.distanceLabel.text = "\(bike.miles) miles"
        self.bike = bike
    }
    
    @IBAction func goButtonTapped(_ sender: UIButton) {
        if let lat = bike?.latitude, let lon = bike?.longitude {
            Direction.init(lat: lat, lon: lon).openMaps()
        }
    }
}
