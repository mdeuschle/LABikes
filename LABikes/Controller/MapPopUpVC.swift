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
    private var favoriteBikes = [Bike]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 10
        view.shadow()
    }

    func updateBikeData(bike: Bike) {
        nameLabel.text = bike.name
        addressLabel.text = bike.addressStreet
        self.bike = bike
        favoriteBikes = Dao().loadFavorites()
        for favoriteBike in favoriteBikes {
            if bike.kioskId == favoriteBike.kioskId {
                favoriteSwitch.setOn(true, animated: false)
            } else {
                favoriteSwitch.setOn(false, animated: false)
            }
        }
    }

    @IBAction func favoriteSwitched(_ sender: UISwitch) {
        guard let bike = bike else {
            return
        }
        if sender.isOn {
            favoriteBikes.append(bike)
            Dao().saveFavorites(bikes: favoriteBikes)
        } else {
            Dao().removeFavorites()
            if let index = bike.getFavoriteIndex(favorites: favoriteBikes) {
                favoriteBikes.remove(at: index)
            }
            Dao().saveFavorites(bikes: favoriteBikes)
        }
    }
    @IBAction func directionsTapped(_ sender: UIButton) {
        
    }
}
