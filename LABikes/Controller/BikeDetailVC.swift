//
//  BikeDetailVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 11/25/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class BikeDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isFavorite: UISwitch!
    var bike: Bike?
    var favoriteBikes = [Bike]()

    init() {
        super.init(nibName: "BikeDetailVC", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        nameLabel.text = bike?.name
        favoriteBikes = Dao().loadFavorites()
        for favoriteBike in favoriteBikes {
            if bike?.kioskId == favoriteBike.kioskId {
                isFavorite.setOn(true, animated: false)
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
            if let index = favoriteBikes.index(where: { $0.kioskId == bike.kioskId }) {
                favoriteBikes.remove(at: index)
            }
            Dao().saveFavorites(bikes: favoriteBikes)
        }
    }
}
