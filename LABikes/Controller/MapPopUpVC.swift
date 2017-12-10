//
//  MapPopUpVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/29/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class MapPopUpVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    private var bike: Bike?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 10
        view.shadow()
    }

    func updateBikeData(bike: Bike) {
        nameLabel.text = bike.name
        addressLabel.text = bike.addressStreet
    }

    @IBAction func favoriteSwitched(_ sender: UISwitch) {

    }
    @IBAction func directionsTapped(_ sender: UIButton) {
        
    }
}
