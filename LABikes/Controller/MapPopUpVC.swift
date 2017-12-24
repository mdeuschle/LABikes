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
    @IBOutlet weak var tempLabel: UILabel!

    private var bike: Bike?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 10
        view.shadow()
    }

    func config(bike: Bike) {
        nameLabel.text = bike.name                                              
        addressLabel.text = bike.addressStreet
        self.bike = bike
    }
    
    @IBAction func directionsTapped(_ sender: UIButton) {
        
    }
}
